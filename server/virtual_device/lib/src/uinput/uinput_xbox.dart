import 'package:core/core.dart';
import 'package:isolate_channel/isolate_channel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:virtual_device/src/models/virtual_device_button.dart';
import 'package:virtual_device/src/models/virtual_device_event.dart';
import 'package:virtual_device/src/models/virtual_device_input.dart';
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
  IsolateConnection ? _vdeIsolate;
  final BehaviorSubject<VirtualDeviceEvent> _vdeSubject = BehaviorSubject();
  
  @override
  Stream<VirtualDeviceEvent> get eventStream => _vdeSubject.stream;

  @override
  Future<void> start(int controllerNumberName) async {
    try{
      _openAndAvilitateEvents();
      _registerAllButtonsAndAxis();
      
      // await _initIsolate();
      
      if(create_device(_fd, controllerNumberName, 1118, 654) < 0){
        throw Exception('Error creating controller');
      }
    }catch(e){
      /// Si el error sucedio luego del openAndAvilateEvent
      if(_fd >= 0) close_device(_fd); 
      throw InitVirtualDeviceException(e.toString());
    }
  }

  @override
  void close(){
    _vdeIsolate?.close();
    close_device(_fd);
    _fd = -1;
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


  @override
  List<VirtualDeviceButton> get availableButtons 
    => UinputXbox._xboxButtons.values.toList();

  @override
  VirtualDeviceButton ? getDefaultVDBfor(PlayerButton btn) 
    => UinputXbox._xboxButtons[btn];


  /// open y habilita eventos abs, key (fd tiene valor o exception)
  void _openAndAvilitateEvents(){
    _fd = open_device();
    if (_fd < 0) throw Exception('Could not open /dev/uinput');
    if (ioctl_ui_set_evbit(_fd, EV_ABS) < 0 ||
        ioctl_ui_set_evbit(_fd, EV_KEY) < 0 ) {
      throw Exception('Could not enable uinput events');
    }
  }

  /// fd tiene que tener valor antes de invocar
  /// recorre los botones y axis existentes y los registra
  void _registerAllButtonsAndAxis(){

    for(final btn in UinputXbox._xboxButtons.values){  
      switch(btn){
        case VirtualDeviceAxisButton():
          _registerAxis(btn);
        case VirtualDeviceSinglePressButton():
          ioctl_ui_set_keybit(_fd, btn.code);
      }
    }
  }


  void _registerAxis(VirtualDeviceAxisButton btn){
    for(final entry in btn.codeByAxis.entries){
      ioctl_ui_set_absbit(
        _fd,
        entry.value,
        btn.minAllowValue,
        btn.maxAllowValue,
        btn.buzz,
        btn.flat,
        0,
      );
    }
  }


  Future<void> _initIsolate() async {
    IsolateMethodChannel ? methodChannel;
    
    _vdeIsolate = await spawnIsolate(
      (sendPort){
        final connection = setupIsolate(sendPort);

        methodChannel = IsolateMethodChannel('method_channel',connection);
        final eventChannel  = IsolateEventChannel('event_channel' , connection);

        methodChannel?.setMethodCallHandler((call){
          switch(call.method){
            case 'listen_to_events':
              // int type = -1, code = -1 , value = -1;
              // while(read_input_event(_fd, type, code, value) != -1){
              //   /// Process event
              // }
              // /// free memorys
            default: 
              return call.notImplemented();
          }
        });

        eventChannel.setStreamHandler(
          IsolateStreamHandler.inline(
            onListen: (arguments, sink){
              if(arguments is VirtualDeviceEvent){
                _vdeSubject.add(arguments);
              }
            }
          )
        );

      },
    );

    methodChannel?.invokeMethod('listen_to_events');
  }

}
