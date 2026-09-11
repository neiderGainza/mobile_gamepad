import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/providers/controller_details_provider.dart';
import 'package:game_controller/presentation/screens/controller_details_view/widgets/my_app_bar.dart';
import 'package:game_controller/presentation/widgets/button_group_painter.dart';
import 'package:game_controller/presentation/widgets/inherited_value.dart';


class ControllerDetailsView extends ConsumerStatefulWidget{
  const ControllerDetailsView({
    super.key,
    required this.controllerId
  });

  final String controllerId;

  @override
  ConsumerState<ControllerDetailsView> createState() => _ControllerDetailsViewState();
}

class _ControllerDetailsViewState extends ConsumerState<ControllerDetailsView> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllerDetails = ref.watch( 
      controllerDetailsProvider(widget.controllerId)
    );
    
    return Scaffold(
      body: controllerDetails.when(
        data: (state) => onData(context, state), 
        error: (_ ,_) => errorWidget(context), 
        loading: (  ) => loadingWidget(context)
      ),
    );   
  } 


  Widget onData(BuildContext context, ControllerDetailsState state){
    final controller = state.controller;

    return InheritedValue<String>(
      value: widget.controllerId, 
      
      child: Stack(
        children: [
          Align( 
            alignment: .topLeft, 
            child: MyAppBar(controller: controller,),),

          for(final posGroup in controller.buttonGroups)
          Align(
            alignment: AlignmentGeometry.xy(
              2 * (posGroup.relativePosition.dx - 0.5), 
              2 * (posGroup.relativePosition.dy - 0.5)               
            ),
            child: ButtonGroupPainter(buttonGroup: posGroup.buttonGroup),
          )

        ],
      ),
    );
  }


  Widget loadingWidget(BuildContext context){
    return Center(child: CircularProgressIndicator(),);
  }

  Widget errorWidget(BuildContext context){
    return Center(child: Text("Error"),);
  }
}
