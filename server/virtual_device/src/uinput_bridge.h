/// @author Neider Gainza + IA (jjj , i am not a c programmer)
/// @brief This exposes the functions necesary to create and used a uinput device
/// Usage:
/// - open_device() and save the fd
/// - add_events(,,,,,) wraper of ioctl allows to create buttons
/// - setup_axis(,,,,) wraper of ioctl to create axis
/// - create_device to close the creation proccess , here you can specify device type
///   like XBox , keyboard etc

#ifndef VIRTUAL_GAMEPAD_H
#define VIRTUAL_GAMEPAD_H

#include <linux/input-event-codes.h>

#ifdef __cplusplus
extern "C" {
#endif

/// @brief Abre /dev/uinput y prepara la sesión
/// @return file descriptor (fd) o -1 en caso de error
int open_device();

/// @brief Lee un evento generado por el dispositivo virtual.
/// @param fd Descriptor de archivo obtenido con open_device
/// @param type Tipo del evento (EV_UINPUT, EV_FF, etc.)
/// @param code Código del evento
/// @param value Valor del evento
/// @return 0 si se leyó un evento, -1 si ocurrió un error
int read_input_event(int fd, int *type, int *code, int *value);

/// @brief calls ioctl(fd, UI_SET_EVBIT, ev)
/// @param fd file descriptor
/// @param ev evento (EV_KEY,EV_ABS,EV_FF,)
/// @return -1 if failed , 0 if success
int ioctl_ui_set_evbit(int fd, int ev);

/// @brief calls ioctl(fd, UI_SET_KEYBIT, value)
/// @param fd Descriptor de archivo obtenido con open_device
/// @param value Código de la tecla/botón/eje (ej: BTN_A, ABS_X)
/// @return 0 en éxito, -1 en error
int ioctl_ui_set_keybit(int fd, int value);

/// @brief calls ioctl(fd, UI_SET_ABSBIT, value)
/// @param fd Descriptor de archivo
/// @param axis Código del eje (ej: ABS_X)
/// @param minimum Valor mínimo del eje
/// @param maximum Valor máximo del eje
/// @param fuzz Tolerancia de ruido del eje
/// @param flat Zona muerta del eje
/// @param resolution Resolución del eje
/// @return 0 en éxito, -1 en error
int ioctl_ui_set_absbit(
  int fd,
  int axis,
  int minimum,
  int maximum,
  int fuzz,
  int flat,
  int resolution
);

/// @brief calls ioctl(fd, UI_SET_RELBIT, value)
/// @param fd Descriptor de archivo obtenido con open_device
/// @param value Código de la tecla/botón/eje (ej: BTN_A, ABS_X)
/// @return 0 en éxito, -1 en error
int ioctl_ui_set_relbit(int fd, int value);

/// @brief calls ioctl(fd, UI_SET_FFBIT, value)
/// @param fd Descriptor de archivo
/// @param value Código del eje (ej: ABS_X)
/// @return 0 en éxito, -1 en error
int ioctl_ui_set_ffbit(int fd, int value);

/// @brief Asigna el nombre al dispositivo y lo registra en el sistema
/// @param fd Descriptor de archivo
/// @param identifier Identificador para formar "Player [identifier]
/// @param vendor Marca de fabricante dispositivo a emular (0x045E XBox)
/// @param product Modelo de dispositivo (0x028E XBox One (no idea)) 
/// @return 0 en éxito, -1 en error
int create_device(int fd, int identifier, int vendor, int product);

/// @brief Libera los recursos del dispositivo y destruye el nodo uinput
/// @param fd Descriptor de archivo
/// @return 0 en éxito
int close_device(int fd);



/// @brief Envía el evento de presionar/liberar botón 
/// (la accion se ejecuta en el proximo sync)
/// @param fd Descriptor de archivo
/// @param button Código del botón (BTN_*)
/// @param value 0 para liberar, 1 para presionar
int press_button(int fd, int button, int value);

/// @brief Envia evento de mover axis (la accion se ejecuta en el proximo sync)
/// @param fd Descriptor de archivo
/// @param axis Código del eje (ABS_*)
/// @param value Valor del eje
int move_axis(int fd, int axis, int value);

/// @brief Sincroniza los movimientos
int sync_device(int fd);

#ifdef __cplusplus
}
#endif

#endif // VIRTUAL_GAMEPAD_H