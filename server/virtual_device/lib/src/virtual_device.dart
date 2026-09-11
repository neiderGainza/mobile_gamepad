import 'dart:io';

import 'package:core/core.dart';
import 'package:virtual_device/src/models/virtual_device_button.dart';
import 'package:virtual_device/src/models/virtual_device_event.dart';
import 'package:virtual_device/src/models/virtual_device_input.dart';
import 'package:virtual_device/src/uinput/uinput_xbox.dart';


/// Representa un dispositivo virtual capaz de recibir y procesar eventos.
///
/// Esta interfaz define el contrato mínimo que cualquier implementación
/// de dispositivo virtual debe cumplir, independientemente de la plataforma
/// subyacente (Windows, Linux).
///
/// ### Responsabilidades
/// - Inicializar el dispositivo virtual y dejarlo listo para recibir eventos.
/// - Liberar recursos y cerrar el dispositivo cuando ya no se necesite.
/// - Procesar eventos 
/// - Exponer DeviceEvents disponibles y sus defaultUserEvents
///
/// Las implementaciones concretas (por ejemplo, `ViGEmVirtualDevice` o
/// `UInputVirtualDevice`) deben encargarse de traducir los eventos abstractos
/// del dominio hacia las llamadas nativas correspondientes.
abstract class VirtualDevice {

  /// Factory constructor, gives the device to the current platform
  factory VirtualDevice.platformDevice(){
    if(Platform.isLinux){
      return UinputXbox();
    }
    
    throw UnimplementedError('Virtual device not implemented');
  }

  /// Inicializa el dispositivo virtual
  /// 
  /// recives [controllerNumberName] the final controller will have the name
  /// of : Player [controllerNumberName]
  /// 
  /// Lanzar excepcion si no es posible
  Future<void> start(int controllerNumberName);

  /// Cierra el dispositivo virtual y libera todos los recursos asociados.
  ///
  /// Este método debe garantizar que el dispositivo queda en un estado
  /// consistente y que no quedan handles abiertos, hilos activos o
  /// referencias nativas sin liberar.
  ///
  /// Es seguro llamar a este método más de una vez; las implementaciones
  /// deben manejar el cierre idempotente.
  void close();

  /// 
  void proccessEvent(List<VirtualDeviceInput> actionsBatch);

  /// Nos da todos los available buttons
  List<VirtualDeviceButton> get availableButtons;

  /// Nos da el default VirtualDeviceButton for el PlayerBtn
  /// el playerBtn debe de ser compatible con el VirtualDeviceButton
  /// (tener definidas las mismas axis)
  VirtualDeviceButton ? getDefaultVDBfor(PlayerButton btn);

  /// Stream de virtual device event
  Stream<VirtualDeviceEvent> get eventStream;
}
