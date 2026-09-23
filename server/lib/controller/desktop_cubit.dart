import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:server/models/desktop_client_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


/// Encargado de escuchar stream de serverState y enviar 
/// informacion pertinente al Desktop
class DesktopCubit extends Cubit<DesktopClientState>{
  // composicion para agregar funcionalidad antes q herencia
  late final Heartbeat _heartbeat;
  late final ChannelEventListener _channelEventListener;

  ///
  DesktopCubit(
    this._webSocketChannel,
    {
      required this.desktopClientId,
      required this.onDisconnect,
      required this.onShoutDownServer
    }
  ):super(const DesktopClientState()){
    _initChannnelEventListener();
    _initHeartbeat();
  }


  final WebSocketChannel _webSocketChannel;

  /// Id temporal del cliente
  final String desktopClientId;

  /// llamar cuando se desconecta el desktop client
  /// util para limpiar activeDesktopConnections 
  final void Function(String desktopClientId) onDisconnect;

  /// call when the desktop orders to shoutDownTheServer
  final void Function() onShoutDownServer;


  /// Utilidad para enviar informacion
  void send(Event event){
    _webSocketChannel.sink.add(event.encode());
  }


  /// Subscriptions 
  void _initChannnelEventListener(){
    _channelEventListener = ChannelEventListener(
      _webSocketChannel, 
      handleEvent: (event){
        switch(event){
          case StopServerDesktopEvent():
            onShoutDownServer();
            return;
        }
      },
      handleNoEvent: (data) {
        send(UnsuportedServerEvent());
      },
    )..start();
  }

  void _initHeartbeat(){
    _heartbeat = Heartbeat(
      _channelEventListener.eventStream,
      _webSocketChannel.sink, 

      pingInterval : const Duration(seconds: 2),
      maxPingFailed: 1,

      onPingChanged: (ping) {},
      
      onConnectionStatusChanged: 
        (newStatus) => emit(state.copyWith(connectionStatus: newStatus)),

      onHeartbeatStop: close     
    )..start();
  }


  @override
  Future<void> close() {
    // cerrar subscripciones locales
    
    // cerrar extensiones
    _heartbeat.stop();
    _channelEventListener.stop();
    
    // cerrar webSocket
    _webSocketChannel.sink.close();

    // reportar cierre
    onDisconnect(desktopClientId);
    return super.close();
  }
}
