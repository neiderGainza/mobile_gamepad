#include "uinput_bridge.h"

#include <linux/uinput.h>
#include <poll.h>
#include <sys/eventfd.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>

int open_device() {
    int fd = open("/dev/uinput", O_RDWR); // read es bloqueante
    if (fd < 0) {
        perror("open /dev/uinput");
        return -1;
    }
    return fd;
}

int open_poll_file() {
    const int fd = eventfd(0, 0);
    if (fd < 0) perror("eventfd poll file");
    return fd;
}

int write_poll_file(int fd, int command) {
    if (fd < 0) {
        errno = EBADF;
        perror("write poll file");
        return -1;
    }

    const uint64_t value = (uint64_t)command;
    if (write(fd, &value, sizeof(value)) != sizeof(value)) {
        perror("write poll file");
        return -1;
    }
    return 0;
}

int close_poll_file(int fd) {
    if (write_poll_file(fd, POLL_CLOSE) < 0) return -1;

    if (close(fd) < 0) {
        perror("close poll file");
        return -1;
    }
    return 0;
}

int read_input_event(int fd, int *type, int *code, int *value) {
    if (fd < 0 || type == NULL || code == NULL || value == NULL) {
        return -1;
    }

    struct input_event event;
    const ssize_t bytes_read = read(fd, &event, sizeof(event));
    if (bytes_read != sizeof(event)) {
        return -1;
    }

    *type = event.type;
    *code = event.code;
    *value = event.value;
    return 0;
}



int read_input_or_poll(int uinput_fd, int poll_fd, 
                        int *type, int *code, int *value, int *command) 
{
    
    if (
        uinput_fd < 0 || poll_fd < 0 || type == NULL || code == NULL ||
        value == NULL || command == NULL
    ) {
        errno = EINVAL;
        perror("read input or poll");
        return -1;
    }


    struct pollfd descriptors[2] = {
        {.fd = uinput_fd, .events = POLLIN},
        {.fd = poll_fd  , .events = POLLIN},
    };

    if (poll(descriptors, 2, -1) < 0) {
        perror("poll input or command");
        return -1;
    }

    if (descriptors[1].revents & (POLLERR | POLLHUP | POLLNVAL)) {
        *command = POLL_CLOSE;
        return 1;
    }

    if (descriptors[1].revents & POLLIN) {
        uint64_t value_from_poll;
        if (
            read(poll_fd, &value_from_poll, 
                sizeof(value_from_poll)) != sizeof(value_from_poll)) 
        {
            perror("read poll file");
            return -1;
        }
        *command = (int)value_from_poll;
        return 1;
    }

    if (descriptors[0].revents & (POLLERR | POLLHUP | POLLNVAL)) {
        errno = EIO;
        perror("poll uinput descriptor");
        return -1;
    }

    struct input_event event;
    if (read(uinput_fd, &event, sizeof(event)) != sizeof(event)) {
        perror("read input event");
        return -1;
    }

    if (event.type == EV_UINPUT) {
        if (event.code == UI_FF_UPLOAD) {
            struct uinput_ff_upload upload;
            memset(&upload, 0, sizeof(upload));
            upload.request_id = event.value;

            if (ioctl(uinput_fd, UI_BEGIN_FF_UPLOAD, &upload) == 0) {
                upload.retval = 0; // 0 = Aceptar la carga del efecto
                ioctl(uinput_fd, UI_END_FF_UPLOAD, &upload);
            }
        } else if (event.code == UI_FF_ERASE) {
            struct uinput_ff_erase erase;
            memset(&erase, 0, sizeof(erase));
            erase.request_id = event.value;

            if (ioctl(uinput_fd, UI_BEGIN_FF_ERASE, &erase) == 0) {
                erase.retval = 0; // 0 = Aceptar borrado
                ioctl(uinput_fd, UI_END_FF_ERASE, &erase);
            }
        }
        
        // Asignamos type como EV_UINPUT para que Dart sepa ignorarlo si lo recibe
        *type = event.type;
        *code = event.code;
        *value = event.value;
        *command = 0;
        return 0;
    }

    *type    = event.type;
    *code    = event.code;
    *value   = event.value;
    *command = 0;
    return 0;
}



int ioctl_ui_set_evbit(int fd, int ev){
    const int result = ioctl(fd, UI_SET_EVBIT, ev);
    if (result < 0) perror("UI_SET_EVBIT ioctl_ui_set_evbit");
    return result;
}

int ioctl_ui_set_keybit(int fd, int value){
    const int result = ioctl(fd, UI_SET_KEYBIT, value);
    if (result < 0) perror("UI_SET_KEYBIT ioctl_ui_set_keybit");
    return result;
}

int ioctl_ui_set_relbit(int fd, int value){ 

    if(ioctl(fd,UI_SET_RELBIT, value) < 0){
        perror("UI_SET_RELBIT ioctl_ui_set_relbit");
        return -1;
    }

    return 0;
}

int ioctl_ui_set_ffbit(int fd, int value){ 

    if(ioctl(fd,UI_SET_FFBIT, value) < 0){
        perror("UI_SET_FFBIT ioctl_ui_set_ffbit");
        return -1;
    }
    
    return 0;
}


int ioctl_ui_set_absbit(
    int fd,
    int axis,
    int minimum,
    int maximum,
    int fuzz,
    int flat,
    int resolution
) {
    if (minimum > maximum || fuzz < 0 || flat < 0 || resolution < 0) {
        perror("UI_ABS_SETUP integrity on ioctl_ui_set_absbit");
        return -1;
    }

    if (ioctl(fd, UI_SET_ABSBIT, axis) < 0) {
        perror("UI_SET_ABSBIT ioctl_ui_set_absbit");
        return -1;
    }
    
    struct uinput_abs_setup a;
    memset(&a, 0, sizeof(a));
    a.code = axis;
    a.absinfo.minimum = minimum;
    a.absinfo.maximum = maximum;
    a.absinfo.value   = 0;
    a.absinfo.fuzz    = fuzz;
    a.absinfo.flat    = flat;
    a.absinfo.resolution = resolution;

    const int result = ioctl(fd, UI_ABS_SETUP, &a);
    if (result < 0) perror("UI_ABS_SETUP ioctl_ui_absbit final");
    return result;
}


int create_device(int fd, int identifier, int vendor, int product) {
    if (fd < 0) return -1;

    struct uinput_setup usetup;
    memset(&usetup, 0, sizeof(usetup));
    usetup.id.bustype = BUS_HOST;
    usetup.id.vendor  = vendor; 
    usetup.id.product = product;
    usetup.ff_effects_max = 16;

    snprintf(usetup.name, UINPUT_MAX_NAME_SIZE, "Player %d", identifier);

    if (ioctl(fd, UI_DEV_SETUP, &usetup) < 0) {
        perror("UI_DEV_SETUP");
        return -1;
    }
    if (ioctl(fd, UI_DEV_CREATE) < 0) {
        perror("UI_DEV_CREATE");
        return -1;
    }

    return 0;
}


int press_button(int fd, int button, int value) {
    if (fd < 0) return -1;

    struct input_event ev;
    memset(&ev, 0, sizeof(ev));
    ev.type = EV_KEY;
    ev.code = button;
    ev.value = value;
    const int result = write(fd, &ev, sizeof(ev));
    if (result < 0) perror("write button event");
    return result;
}


int move_axis(int fd, int axis, int value) {
    if (fd < 0) return -1;

    struct input_event ev;
    memset(&ev, 0, sizeof(ev));
    ev.type = EV_ABS;
    ev.code = axis;
    ev.value = value;
    const int result = write(fd, &ev, sizeof(ev));
    if (result < 0) perror("write axis event");
    return result;
}


int sync_device(int fd){
    struct input_event ev;
    memset(&ev, 0, sizeof(ev));
    ev.type = EV_SYN;
    ev.code = SYN_REPORT;
    const int result = write(fd, &ev, sizeof(ev));
    if (result < 0) perror("write sync event");
    return result;
}


int close_device(int fd) {
    if (fd >= 0) {
        ioctl(fd, UI_DEV_DESTROY);
        close(fd);
    }
    return 0;
}