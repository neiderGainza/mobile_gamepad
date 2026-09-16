import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:rxdart/rxdart.dart';
import 'package:virtual_device/virtual_device.dart';


/// Encargado de recibir los eventos del player mutar el estado
/// emitir los eventos del sever hacia el player
/// Puente entre virtualDevice y player
class PlayerCubit extends Cubit<PlayerState?>{
  Heartbeat     ? _heartbeat;
  VirtualDevice ? _virtualDevice;
  CheckPool     ? _checkPool;  
  
  // subscritpions
  StreamSubscription<VirtualDeviceEvent> ? _vdEventSubscription; 
  StreamSubscription<dynamic> ? _userInputSubscription;
  
  // necesario para inicalizar _hearbeat y checkpool
  // se alimenta de _userInputSubscription (subcripcion a _webSocketChannel)
  final BehaviorSubject<Event> _eventSubject = BehaviorSubject();


  /// Constructor
  PlayerCubit(this._webSocketChannel, {
    required this.playerNumber,
    required this.onPlayerAuth,
    required this.onPlayerDisconnect,
    required this.onPlayerStateUpdated,
  }): super(null) {
    _initUserInputSubscription();
    _initHeartbeat();
    _initCheckPool();
  }
  
  final WebSocketChannel   _webSocketChannel;

  /// Player number for naming the controller (ejem: Player 1)
  final int playerNumber;

  /// Callback
  final void Function(String playerId, PlayerCubit cubit) onPlayerAuth;
  /// Callback
  final void Function(String playerId) onPlayerDisconnect;
  /// Callback
  final void Function(PlayerState state) onPlayerStateUpdated;
  
  
  /// Eventos
  void _onPlayerUpdateInfo(UpdateInfoPlayerEvent event){
    if(state == null){
      onPlayerAuth(event.player.id, this);
      emit(PlayerState(player: event.player , connectionStatus: .connected));
      _webSocketChannel.sink.add(SuccessCheckEvent(id: event.id).encode());
      
      _createVirtualDevice();
    }else{
      emit(state!.copyWith(player: event.player, connectionStatus: .connected));
      _webSocketChannel.sink.add(SuccessCheckEvent(id: event.id).encode());
    }
  }
  
  void _onPlayerDisconnectEvent(DisconnectPlayerEvent event){
    emit(state?.copyWith(connectionStatus: .disconnected, ping: null));
    onPlayerDisconnect(state!.player.id);
    close();
  }

  void _onPlayerBtnEvent(ButtonPlayerEvent event) async {
    if(state == null){
      _requestInfoSync();
      return;
    }
    
    if(_virtualDevice == null){
      await _createVirtualDevice();
      return;
    }

    final vdb = _virtualDevice?.getDefaultVDBfor(event.btn);
    if(vdb != null){
      _virtualDevice?.proccessEvent([
        VirtualDeviceInput(button: vdb, axis:event.axis, value: event.value)
      ]);
    }
  }

  void _requestInfoSync(){
    _webSocketChannel.sink.add(PlayerInfoRequestServerEvent().encode());
  }


  /// Create virtual device
  Future<void> _createVirtualDevice() async {
    try{
      _virtualDevice = VirtualDevice.platformDevice();
      await _virtualDevice!.start(playerNumber);
      _initVDEventSubscription(_virtualDevice!);
    
    }catch(e){
      
      switch(e){
        case VirtualDeviceException():
          _webSocketChannel.sink.add(
            FailInitVDEvent(error:e.message??'Fallo de inicialización').encode()
          );
        default:
          _webSocketChannel.sink.add(const 
            FailInitVDEvent(error:'Fallo inesperado de inicialización').encode()
          );
      }
      
      _virtualDevice = null;
    }
  }

  
  /// Subscriptions
  /// Inicializando subscripciones
  void _initHeartbeat(){
    _heartbeat = Heartbeat(
      _eventSubject.stream,
      _webSocketChannel.sink, 

      onPingChanged : 
        (newPing) => emit(state?.copyWith(ping: newPing)), 
      
      onConnectionStatusChanged: 
        (newStatus) => emit(state?.copyWith(connectionStatus: newStatus)),
      
      onHeartbeatStop: close, 
    );
  }

  void _initCheckPool(){
    _checkPool = CheckPool(
      _eventSubject.stream, 
      _webSocketChannel.sink
    );
  }

  void _initUserInputSubscription(){
    _userInputSubscription?.cancel();
    _userInputSubscription = _webSocketChannel.stream.listen(
      (data){
        
        try{
          final event = Event.decode(data);
          
          switch(event){
            case final UpdateInfoPlayerEvent event:
              _onPlayerUpdateInfo(event);
            case final DisconnectPlayerEvent event:
              _onPlayerDisconnectEvent(event);
            case final ButtonPlayerEvent event:
              _onPlayerBtnEvent(event);
          }

          _eventSubject.add(event);
        }catch(_){}
      },
      onDone: (){
        _onPlayerDisconnectEvent(DisconnectPlayerEvent());
      },
    );
  }

  void _initVDEventSubscription(VirtualDevice vd){
    _vdEventSubscription?.cancel();
    _vdEventSubscription = vd.eventStream.listen(
      (vde){
        _webSocketChannel.sink.add(vde.encode());
      }
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
    _userInputSubscription?.cancel();
    _userInputSubscription = null;
    _vdEventSubscription?.cancel();
    _vdEventSubscription = null;

    _heartbeat?.stop();
    _heartbeat = null;
    _checkPool?.stop();
    _checkPool = null;
    _virtualDevice?.close();
    _virtualDevice = null;

    _eventSubject.close();
    _webSocketChannel.sink.close();
    return super.close();
  }

}
