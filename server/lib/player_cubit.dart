import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:virtual_device/virtual_device.dart';

import 'package:web_socket_channel/status.dart' as status;


/// Encargado de recibir los eventos del player mutar el estado
/// y emitir los eventos del sever hacia el player
class PlayerCubit extends Cubit<PlayerState?>{
  ///
  PlayerCubit(this._webSocketChannel, {
    required this.playerNumber,
    required this.onPlayerAuth,
    required this.onPlayerDisconnect,
    required this.onPlayerStateUpdated,
  }): _serverEventStream = _webSocketChannel.stream.asBroadcastStream() 
    , super(null) {

    _initUserInputSubscription();
    _startAuthTimer();
    _initHeartbeat();
  }
  
  final WebSocketChannel   _webSocketChannel;
  Heartbeat ? _heartbeat;
  VirtualDevice ? _virtualDevice;
  final int playerNumber;

  /// broadcast del [_webSockectChannel.stream]
  final Stream<dynamic> _serverEventStream;
  

  /// Callback
  final void Function(String playerId, PlayerCubit cubit) onPlayerAuth;
  /// Callback
  final void Function(String playerId) onPlayerDisconnect;
  /// Callback
  final void Function(PlayerState state) onPlayerStateUpdated;
  

  // subscritpions
  StreamSubscription<dynamic  > ? _userInputSubscription;
  Timer ? _authTimer;

  
  /// Eventos
  void _onPlayerUpdateInfo(UpdateInfoPlayerEvent event){
    _authTimer?.cancel();
    
    emit( 
      state
        ?.copyWith( player: event.player , connectionStatus: .connected)
        ?? PlayerState(player: event.player, connectionStatus: .connected)
      );

    onPlayerAuth(state!.player.id, this); // callback
    _createVirtualDevice();
  }
  
  void _onPlayerDisconnectEvent(DisconnectPlayerEvent event){
    emit(state?.copyWith(connectionStatus: .disconnected, ping: null));
    onPlayerDisconnect(state!.player.id);
    close();
  }

  void _onPlayerBtnEvent(ButtonPlayerEvent event){
    if(state == null){
      _handleEventBeforeInfoSync();
      return;
    }
    
    if(_virtualDevice == null){
      /// TODO : SEND PROBLEM TO FRONTED
      return;
    }

    final vdb = _virtualDevice!.getDefaultVDBfor(event.btn);
    if(vdb != null){
      _virtualDevice!.proccessEvent([
        VirtualDeviceInput(button: vdb, axis:event.axis, value: event.value)
      ]);
    }
  }

  void _handleEventBeforeInfoSync(){
    _webSocketChannel.sink.add(PlayerInfoRequestServerEvent().encode());
  }


  /// Subscriptions
  void _startAuthTimer(){
    _authTimer = Timer( const Duration(seconds: 8), close );
  }

  void _createVirtualDevice(){
    try{
      _virtualDevice = VirtualDevice.platformDevice();
      _virtualDevice!.start(playerNumber);
    }catch(e){
      /// TODO : send error message to frontend
    }
  }

  void _initHeartbeat(){
    _heartbeat = Heartbeat(
      _serverEventStream,
      _webSocketChannel.sink, 

      onPingChanged : 
        (newPing) => emit(state?.copyWith(ping: newPing)), 
      
      onConnectionStatusChanged: 
        (newStatus) => emit(state?.copyWith(connectionStatus: newStatus)),
      
      onHeartbeatStop: close, 
    );
  }

  void _initUserInputSubscription(){
    _userInputSubscription = _serverEventStream.listen(
      (data){
        if(PlayerEvent.isPlayerEvent(data)){
          final playerEvent = PlayerEvent.decode(data);
          
          switch(playerEvent){
            case final UpdateInfoPlayerEvent event:
              _onPlayerUpdateInfo(event);
            case final DisconnectPlayerEvent event:
              _onPlayerDisconnectEvent(event);
            case final ButtonPlayerEvent event:
              _onPlayerBtnEvent(event);
          }
        }
      },
      onDone: (){
        _onPlayerDisconnectEvent(DisconnectPlayerEvent());
      },
    );
  }


  @override
  void onChange(Change<PlayerState?> change) {
    if(change.nextState != null){
      onPlayerStateUpdated(change.nextState!);
    }
    super.onChange(change);
  }

  @override
  Future<void> close() {
    _authTimer?.cancel();
    _userInputSubscription?.cancel();
    
    _heartbeat?.stopHeartbeat();
    _virtualDevice?.close();
    
    _webSocketChannel.sink.close(status.goingAway);
    return super.close();
  }

}
