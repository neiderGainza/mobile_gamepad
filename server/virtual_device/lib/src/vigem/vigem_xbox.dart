import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:core/core.dart';
import 'package:ffi/ffi.dart';

import 'package:rxdart/subjects.dart';
import 'package:virtual_device/src/models/virtual_device_button.dart';
import 'package:virtual_device/src/models/virtual_device_input.dart';
import 'package:virtual_device/src/vigem/vigem_bridge.dart';
import 'package:virtual_device/src/virtual_device.dart';

import 'package:core/src/models/btn/player_button.dart';
import 'package:core/src/models/event/virtual_device_event.dart';


class VigemXBox implements VirtualDevice {
   static final Map<PlayerButton,VirtualDeviceButton> _xboxButtons = {
    .btnA : VirtualDeviceSinglePressButton(code: XUSB_BUTTON.XUSB_GAMEPAD_A.value , i10nKey: 'btnA'),
    .btnB : VirtualDeviceSinglePressButton(code: XUSB_BUTTON.XUSB_GAMEPAD_B.value , i10nKey: 'btnB'),
    .btnX : VirtualDeviceSinglePressButton(code: XUSB_BUTTON.XUSB_GAMEPAD_X.value , i10nKey: 'btnX'),
    .btnY : VirtualDeviceSinglePressButton(code: XUSB_BUTTON.XUSB_GAMEPAD_Y.value , i10nKey: 'btnY'),
    
    .menu : VirtualDeviceSinglePressButton(code: XUSB_BUTTON.XUSB_GAMEPAD_BACK.value  , i10nKey: 'menu'),
    .view : VirtualDeviceSinglePressButton(code: XUSB_BUTTON.XUSB_GAMEPAD_START.value , i10nKey: 'view'),
    
    // joysticks on my languaje
    .ls   : VirtualDeviceAxisButton(
      codeByAxis: {.horizontal: XUSB_BUTTON.XUSB_GAMEPAD_LEFT_THUMB.value , .vertical : XUSB_BUTTON.XUSB_GAMEPAD_LEFT_THUMB.value}, 
      i10nKey: 'ls',
      minAllowValue: -32768,
      maxAllowValue: 32767,
    ),
    .rs   : VirtualDeviceAxisButton(
      codeByAxis: {.horizontal: XUSB_BUTTON.XUSB_GAMEPAD_RIGHT_THUMB.value, .vertical: XUSB_BUTTON.XUSB_GAMEPAD_RIGHT_THUMB.value},
      i10nKey: 'rs',
      minAllowValue: -32768,
      maxAllowValue: 32767,
    ),
    .rt   : VirtualDeviceAxisButton(
      codeByAxis: {.depth: XUSB_BUTTON.XUSB_GAMEPAD_RIGHT_SHOULDER.value}, 
      i10nKey: 'rt',
      minAllowValue: 0,
      maxAllowValue: 255,
    ),
    .lt   : VirtualDeviceAxisButton(
      codeByAxis: {.depth: XUSB_BUTTON.XUSB_GAMEPAD_LEFT_SHOULDER.value}, 
      i10nKey: 'lt',
      minAllowValue: 0,
      maxAllowValue: 255,
    ),
    .dpad  : const VirtualDeviceAxisButton(
      codeByAxis: {.horizontal: -1, .vertical: -1},
      i10nKey: 'dpad',
      minAllowValue: -1,
      maxAllowValue: 1,
      buzz: 0,
      flat: 0
    ),
  };
  

  final BehaviorSubject<VirtualDeviceEvent> _vdeSubject = BehaviorSubject();
  Timer ? _vibrationPooler;

  @override
  Stream<VirtualDeviceEvent> get eventStream => _vdeSubject.stream;

  static int userCount = 0;
  static PVIGEM_CLIENT ? __pVigemClient;

  static PVIGEM_CLIENT get _pVigemClient {
    __pVigemClient??=vigem_alloc();
    return __pVigemClient!;
  }



  PVIGEM_TARGET ? _controller;
  Pointer<XUSB_REPORT> ? _controllerReport;

  @override 
  Future<void> start(int controllerNumberName) async {
    try{
      final connectError = vigem_connect(_pVigemClient);
      
      switch(connectError){
        case .VIGEM_ERROR_NONE :
          break;
        case .VIGEM_ERROR_ALREADY_CONNECTED:
          break;
        case .VIGEM_ERROR_BUS_ALREADY_CONNECTED:
          break;
        default:
          throw Exception(connectError.toString());
      }

      _controller =  vigem_target_x360_alloc();    
      final addTargetError = vigem_target_add(_pVigemClient, _controller!);

      switch(addTargetError){
        case .VIGEM_ERROR_NONE :
          break;
        case .VIGEM_ERROR_ALREADY_CONNECTED:
          break;
        case .VIGEM_ERROR_BUS_ALREADY_CONNECTED:
          break;
        default:
          throw Exception(addTargetError.toString());
      }
      _initVabritationPooler();
      _controllerReport = calloc<XUSB_REPORT>();
      userCount++;
    }catch(e){
      print('VigemXBox.start() error: $e');
      rethrow;
    }
  }

  @override
  void close() {
    _vibrationPooler?.cancel();
    if(_controller != null){
      userCount --;

      vigem_target_remove(_pVigemClient,_controller!);
      vigem_target_free(_controller!);
      calloc.free(_controllerReport!);

      if(userCount == 0){
        vigem_disconnect(_pVigemClient);
      }
    }
  }


  @override
  void proccessEvent(List<VirtualDeviceInput> actionsBatch) {
    if(_controllerReport == null || _controller == null) return;
    final usbReport = _controllerReport!;
    

    for(final action in actionsBatch){
      final btn     = action.button;
       
      switch(btn){
        case VirtualDeviceSinglePressButton():
          _proccessSinglePress(btn, action.value);
          continue;
        
        case VirtualDeviceAxisButton():
          if(btn.i10nKey == 'dpad'){
            _proccessDpadPRess(btn, action.axis, action.value);
          }else{
            _proccessAxisPress(btn, action.axis, action.value);
          }
          continue;
      }
    }
    
    vigem_target_x360_update(
      _pVigemClient,
      _controller!,
      usbReport.ref
    );
  }

  void _proccessSinglePress(VirtualDeviceSinglePressButton btn, double value){
    final usbReport = _controllerReport!;
    final btnCode = XUSB_BUTTON.fromValue(btn.code);
          
    usbReport.ref.wButtons = value == 0
      ? usbReport.ref.wButtons &= ~btnCode.value
      : usbReport.ref.wButtons |= btnCode.value;
  }

  void _proccessAxisPress(VirtualDeviceAxisButton btn, ButtonAxis axis, double value){
    if(btn.codeByAxis[axis] == null) return;
    
    final usbReport = _controllerReport!;
    final axisCode  = XUSB_BUTTON.fromValue(btn.codeByAxis[axis]!);

    // right joystick
    if(axisCode == .XUSB_GAMEPAD_RIGHT_THUMB){
      axis == .horizontal
        ? usbReport.ref.sThumbRX = btn.scaleInputValue(value)
        : usbReport.ref.sThumbRY = btn.scaleInputValue(value);
      return;
    }   
    // left joystick
    if(axisCode == .XUSB_GAMEPAD_LEFT_THUMB){
      axis == .horizontal
        ? usbReport.ref.sThumbLX = btn.scaleInputValue(value)
        : usbReport.ref.sThumbLY = btn.scaleInputValue(value);
      return;
    }   

    // right trigger
    if(axisCode == .XUSB_GAMEPAD_RIGHT_SHOULDER){
      usbReport.ref.bRightTrigger = btn.scaleInputValue(value);
      return;
    }   
    // left trigger
    if(axisCode == .XUSB_GAMEPAD_LEFT_SHOULDER){
      usbReport.ref.bLeftTrigger = btn.scaleInputValue(value);
      return;
    }   
  }

  /// dpad is an axisButton for user and 4 buttons for vigem, so , 
  /// hay que hacer la transformacion
  void _proccessDpadPRess(VirtualDeviceAxisButton btn, ButtonAxis axis, double value){
    if(btn.i10nKey != 'dpad') return;
    
    if(axis == .horizontal){
      _proccessSinglePress(VirtualDeviceSinglePressButton(
        code: XUSB_BUTTON.XUSB_GAMEPAD_DPAD_RIGHT.value, 
        i10nKey: ''
      ), value > 0.05 ? 1 : 0);
      _proccessSinglePress(VirtualDeviceSinglePressButton(
        code: XUSB_BUTTON.XUSB_GAMEPAD_DPAD_LEFT.value, 
        i10nKey: ''
      ),value < -0.05 ? 1 : 0);
    }else{
      _proccessSinglePress(VirtualDeviceSinglePressButton(
        code: XUSB_BUTTON.XUSB_GAMEPAD_DPAD_UP.value, 
        i10nKey: ''
      ), value > 0.05 ? 1 : 0);
      _proccessSinglePress(VirtualDeviceSinglePressButton(
        code: XUSB_BUTTON.XUSB_GAMEPAD_DPAD_DOWN.value, 
        i10nKey: ''
      ),value < -0.05 ? 1 : 0);
    }
  }

  void _initVabritationPooler(){
    _vibrationPooler?.cancel();
    _vibrationPooler = Timer.periodic(
      Duration(milliseconds: 16),
      (_){
        if(_controller == null) return;
        final rumble = vigem_target_get_rumble(_controller!);

        final small = rumble.smallMotor;
        final large = rumble.largeMotor;

        if( small != 0 || large != 0){
          _vdeSubject.add(VibrationVDEvent(id: 1, value: max(small, large)));
        }
      }
    );
  }

  @override
  List<VirtualDeviceButton> get availableButtons => _xboxButtons.values.toList();

  @override
  VirtualDeviceButton? getDefaultVDBfor(PlayerButton btn) => _xboxButtons[btn];
}
