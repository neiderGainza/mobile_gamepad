import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:virtual_device/virtual_device.dart';


/// Encargado de recibir los eventos del player y
/// emitir los eventos del sever hacia el player
/// 
/// Puente entre virtualDevice y player
/// 
/// Por q un cubit ? porq puedo interceptar con facilidad los cambios de estados
/// con onchanged y puedo manejar el close con onClose
class PlayerCubit extends Cubit<PlayerState?>{
  late final Heartbeat _heartbeat;
  late final CheckPool _checkPool;  
  late final ChannelEventListener _channelEventListener;

  VirtualDevice ? _virtualDevice;
  StreamSubscription<VirtualDeviceEvent> ? _vdEventSubscription; 
  

  /// Constructor
  PlayerCubit(this._webSocketChannel, {
    required this.playerNumber,
    required this.onPlayerAuth,
    required this.onPlayerDisconnect,
    required this.onPlayerStateUpdated,
    required this.onPlayerPingUpdated,
  }): super(null) {
    _initChannnelEventListener();
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
  final void Function(String playerId, Duration ? ping) onPlayerPingUpdated;
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
    emit(state?.copyWith(connectionStatus: .disconnected));
    close();
  }

  Future<void> _onPlayerBtnEvent(ButtonPlayerEvent event) async {
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

  Future<void> _onPlayerMultiButtonEvent(MultiButtonPlayerEvent event) async{
    if(state == null){
      _requestInfoSync();
      return;
    }
    
    if(_virtualDevice == null){
      await _createVirtualDevice();
      return;
    }

    final List<VirtualDeviceInput> vdes = [];
    
    for(final subEvent in event.buttonPlayerEvents){
      final vdb = _virtualDevice?.getDefaultVDBfor(subEvent.btn);
      if(vdb != null){
        vdes.add(VirtualDeviceInput(
          button: vdb, 
          axis  : subEvent.axis,
          value : subEvent.value
        ));
      }
    }
    _virtualDevice?.proccessEvent(vdes);
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
          print("Error inicializing device : ${e.message}");
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
  void _initChannnelEventListener(){
    _channelEventListener = ChannelEventListener(
      _webSocketChannel, 
      handleEvent: (event){
        switch(event){
          case final UpdateInfoPlayerEvent event:
            _onPlayerUpdateInfo(event);
          case final DisconnectPlayerEvent event:
            _onPlayerDisconnectEvent(event);
          case final ButtonPlayerEvent event:
            _onPlayerBtnEvent(event);
          case final MultiButtonPlayerEvent event:
            _onPlayerMultiButtonEvent(event);
        }
      },
      handleNoEvent: (data) {
        _webSocketChannel.sink.add(UnsuportedServerEvent().encode());
      },
    )..start();
  }

  void _initHeartbeat(){
    _heartbeat = Heartbeat(
      _channelEventListener.eventStream, 
      _webSocketChannel.sink, 
      
      onPingChanged: (newPing){
          if(state != null) onPlayerPingUpdated(state!.player.id, newPing);
        },

      onConnectionStatusChanged: 
        (newStatus) => emit(state?.copyWith(connectionStatus: newStatus)),
      
      onHeartbeatStop: close
    )..start();
  }

  void _initCheckPool(){
    _checkPool = CheckPool(
      _channelEventListener.eventStream, 
      _webSocketChannel.sink
    )..start();
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
    final playerId = state?.player.id;

    // cancel local subscriptions
    _vdEventSubscription?.cancel();
    _vdEventSubscription = null;

    // stop extensions
    _heartbeat.stop();
    _checkPool.stop();
    _virtualDevice?.close();

    // clsoe webSocket
    _webSocketChannel.sink.close();
    // notificar a superiores
    if(playerId != null) onPlayerDisconnect(playerId);

    return super.close();
  }

}
