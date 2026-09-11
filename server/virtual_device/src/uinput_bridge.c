#include "uinput_bridge.h"

#include <linux/uinput.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

int open_device() {
    int fd = open("/dev/uinput", O_RDWR); // read es bloqueante
    if (fd < 0) {
        return -1;
    }
    return fd;
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

int ioctl_ui_set_evbit(int fd, int ev){
    const int result = ioctl(fd, UI_SET_EVBIT, ev);
    if (result < 0) perror("UI_SET_EVBIT");
    return result;
}

int ioctl_ui_set_keybit(int fd, int value){
    const int result = ioctl(fd, UI_SET_KEYBIT, value);
    if (result < 0) perror("UI_SET_KEYBIT");
    return result;
}

int ioctl_ui_set_relbit(int fd, int value){ 

    if(ioctl(fd,UI_SET_RELBIT, value) < 0){
        return -1;
    }

    return 0;
}

int ioctl_ui_set_ffbit(int fd, int value){ 

    if(ioctl(fd,UI_SET_FFBIT, value) < 0){
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
        perror("UI_ABS_SETUP");
        return -1;
    }

    if (ioctl(fd, UI_SET_ABSBIT, axis) < 0) {
        perror("UI_SET_ABSBIT");
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
    if (result < 0) perror("UI_ABS_SETUP");
    return result;
}


int create_device(int fd, int identifier, int vendor, int product) {
    if (fd < 0) return -1;

    struct uinput_setup usetup;
    memset(&usetup, 0, sizeof(usetup));
    usetup.id.bustype = BUS_HOST;
    usetup.id.vendor  = vendor; 
    usetup.id.product = product;

    snprintf(usetup.name, UINPUT_MAX_NAME_SIZE, "Player %d", identifier);

    if (ioctl(fd, UI_DEV_SETUP, &usetup) < 0) return -1;
    if (ioctl(fd, UI_DEV_CREATE) < 0) return -1;

    return 0;
}


int press_button(int fd, int button, int value) {
    if (fd < 0) return -1;

    struct input_event ev;
    memset(&ev, 0, sizeof(ev));
    ev.type = EV_KEY;
    ev.code = button;
    ev.value = value;
    return write(fd, &ev, sizeof(ev));
}


int move_axis(int fd, int axis, int value) {
    if (fd < 0) return -1;

    struct input_event ev;
    memset(&ev, 0, sizeof(ev));
    ev.type = EV_ABS;
    ev.code = axis;
    ev.value = value;
    return write(fd, &ev, sizeof(ev));
}


int sync_device(int fd){
    struct input_event ev;
    memset(&ev, 0, sizeof(ev));
    ev.type = EV_SYN;
    ev.code = SYN_REPORT;
    return write(fd, &ev, sizeof(ev));
}


int close_device(int fd) {
    if (fd >= 0) {
        ioctl(fd, UI_DEV_DESTROY);
        close(fd);
    }
    return 0;
}