import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:core/core.dart';
import 'package:ffi/ffi.dart' as ffi_allocator;
import 'package:isolate_channel/isolate_channel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:virtual_device/src/models/virtual_device_button.dart';
import 'package:virtual_device/src/models/virtual_device_input.dart';
import 'package:virtual_device/src/uinput/uinput_rumble_const.dart';
import '../exception/virtual_device_exception.dart';
import 'uinput_bridge.dart';
import '../virtual_device.dart';

///
class UinputXbox implements VirtualDevice {
  static final Map<PlayerButton,VirtualDeviceButton> _xboxButtons = {
    .btnA : const VirtualDeviceSinglePressButton(code: BTN_A, i10nKey: 'btnA'),
    .btnB : const VirtualDeviceSinglePressButton(code: BTN_B, i10nKey: 'btnB'),
    .btnX : const VirtualDeviceSinglePressButton(code: BTN_X, i10nKey: 'btnX'),
    .btnY : const VirtualDeviceSinglePressButton(code: BTN_Y, i10nKey: 'btnY'),
    .lb   : const VirtualDeviceSinglePressButton(code: BTN_TL, i10nKey: 'lb'),
    .rb   : const VirtualDeviceSinglePressButton(code: BTN_TR, i10nKey: 'rb'),
    .lt   : const VirtualDeviceSinglePressButton(code: BTN_TL2, i10nKey: 'lt'),
    .rt   : const VirtualDeviceSinglePressButton(code: BTN_TR2, i10nKey: 'rt'),
    .menu : const VirtualDeviceSinglePressButton(code: BTN_START, i10nKey: 'menu'),
    .view : const VirtualDeviceSinglePressButton(code: BTN_SELECT, i10nKey: 'view'),
    .xbox : const VirtualDeviceSinglePressButton(code: BTN_MODE, i10nKey: 'xbox'),
    

    .ls   : const VirtualDeviceAxisButton(
      codeByAxis: {.horizontal: ABS_X, .vertical: ABS_Y},
      i10nKey: 'ls',
      minAllowValue: -32768,
      maxAllowValue: 32767,
    ),
    .rs   : const VirtualDeviceAxisButton(
      codeByAxis: {.horizontal: ABS_RX, .vertical: ABS_RY},
      i10nKey: 'rs',
      minAllowValue: -32768,
      maxAllowValue: 32767,
    ),
    .dpad  : const VirtualDeviceAxisButton(
      codeByAxis: {.horizontal: ABS_HAT0X, .vertical: ABS_HAT0Y},
      i10nKey: 'dpad',
      minAllowValue: -1,
      maxAllowValue: 1,
      buzz: 0,
      flat: 0
    ),
  };

  int _fd = -1;
  int _fdPoll = -1;

  IsolateConnection ? _vdeIsolate;
  final BehaviorSubject<VirtualDeviceEvent> _vdeSubject = BehaviorSubject();
  
  @override
  Stream<VirtualDeviceEvent> get eventStream 
    => _vdeSubject.stream;

    @override
  List<VirtualDeviceButton> get availableButtons 
    => UinputXbox._xboxButtons.values.toList();

  @override
  VirtualDeviceButton ? getDefaultVDBfor(PlayerButton btn) 
    => UinputXbox._xboxButtons[btn];

  @override
  Future<void> start(int controllerNumberName) async {
    try{
      close();

      _fd     = open_device();
      _fdPoll = open_poll_file();
      
      if(_fd < 0 || _fdPoll < 0){
        throw Exception("Error opening devices");
      }

      if(  ioctl_ui_set_evbit(_fd, EV_ABS) < 0 // axis 
        || ioctl_ui_set_evbit(_fd, EV_KEY) < 0 // botones
        || ioctl_ui_set_evbit(_fd, EV_FF ) < 0 // vibracion

        || _registerAllButtonsAndAxis() < 0 // 
        || _registerVibration() < 0
      ) { 
        throw Exception('Error registering events');
      }
      
      if(create_device(_fd, controllerNumberName, 1118, 654) < 0){
        throw Exception('Error creating controller');
      }
      
      if( (await _initIsolate()) < 0) {
        throw Exception('Error maneging Isolate');
      }
    }catch(e){
      if(_fd >= 0) close_device(_fd); 
      throw InitVirtualDeviceException(e.toString());
    }
  }

  @override
  void close(){
    _vdeSubject.drain();

    if(_fdPoll != -1){
      write_poll_file(_fdPoll, POLL_CLOSE);
      close_poll_file(_fdPoll);
    }
    if(_fd != -1) close_device(_fd);

    _fd = -1;
    _fdPoll = -1;

    _vdeIsolate?.close();
    _vdeIsolate = null;
  }
  
  @override
  void proccessEvent(List<VirtualDeviceInput> actionsBatch) {
    for(final action in actionsBatch){
      switch(action.button){
        case VirtualDeviceSinglePressButton():
          final actionBtn = action.button as VirtualDeviceSinglePressButton;
          press_button(
            _fd, 
            actionBtn.code, 
            actionBtn.scaleInputValue(action.value)
          );
        case VirtualDeviceAxisButton():
          final actionBtn = action.button as VirtualDeviceAxisButton;
          final axisCode  = actionBtn.codeByAxis[action.axis];
          if(axisCode == null) continue; // TODO: throw exception
          move_axis(
            _fd, 
            axisCode, 
            actionBtn.scaleInputValue(action.value)
          );
      }
    }
    sync_device(_fd);
  }



  /// fd tiene que tener valor antes de invocar
  /// recorre los botones y axis existentes y los registra
  int _registerAllButtonsAndAxis(){

    for(final btn in UinputXbox._xboxButtons.values){  
      switch(btn){
        case VirtualDeviceAxisButton():
          if(_registerAxis(btn) < 0) return -1;
        case VirtualDeviceSinglePressButton():
          if(ioctl_ui_set_keybit(_fd, btn.code) < 0) return -1;
      }
    }
    return 0;
  }


  int _registerAxis(VirtualDeviceAxisButton btn){
    for(final entry in btn.codeByAxis.entries){
      if(ioctl_ui_set_absbit(
        _fd,
        entry.value,
        btn.minAllowValue,
        btn.maxAllowValue,
        btn.buzz,
        btn.flat,
        0,
      ) < 0){ return -1; }
    }
    return 0;
  }


  int _registerVibration(){
    if(  
      
      ioctl_ui_set_ffbit(_fd, FF_RUMBLE) < 0
      || false

    ){ return -1; }
    return 0 ;
  }


  Future<int> _initIsolate() async {

    _vdeIsolate = await spawnIsolate(
      (sendPort){
        final connection   = setupIsolate(sendPort);
        final eventChannel = IsolateEventChannel('event_channel', connection);

        eventChannel.setStreamHandler(
          IsolateStreamHandler.inline( onListen: _isolateTask )
        );
      },
    );

    final eventChannel = IsolateEventChannel('event_channel', _vdeIsolate!);
    eventChannel.receiveBroadcastStream((_fd, _fdPoll)).listen((event){
      if(event is VirtualDeviceEvent){
        _vdeSubject.add(event);
      }

    });
    
    return 0;
  }


  static void _isolateTask(dynamic arguments, IsolateEventSink sink){
    final (fd, fdPoll)   = arguments as (int, int);
    
    final type   = ffi_allocator.calloc<ffi.Int>();
    final code   = ffi_allocator.calloc<ffi.Int>();
    final value  = ffi_allocator.calloc<ffi.Int>();
    final comand = ffi_allocator.calloc<ffi.Int>();

    try {
      while(true){
        final result = read_input_or_poll(
          fd, fdPoll, type, code, value, comand);

        sink.success(result);
        
        if(result < 0) break;// an error

        if(result == 0){
          switch(type.value){
            case EV_FF:
              sink.success( VibrationVDEvent(id: code.value, value: value.value));
          }
        }else if(result == 1){
          switch(comand.value){
            case POLL_CLOSE:
              sink.endOfStream();
              return;
          }
        }
      }

    } catch(e){
      sink.success(e.toString());
    } finally {
      ffi_allocator.calloc.free(type);
      ffi_allocator.calloc.free(code);
      ffi_allocator.calloc.free(value);
    }
  }
}
