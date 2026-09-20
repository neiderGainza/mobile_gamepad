import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/core/navigation/navigation.dart';
import 'package:game_controller/data/static_collections/default_controller.dart';
import 'package:game_controller/domain/model/controller.dart';
import 'package:game_controller/presentation/providers/connection_message_provider.dart';
import 'package:game_controller/presentation/providers/controller_details_provider.dart';
import 'package:game_controller/presentation/screens/controller_details_view/widgets/my_app_bar.dart';
import 'package:game_controller/presentation/screens/controller_details_view/widgets/status_indicators.dart';
import 'package:game_controller/presentation/utils/orientation_function_collection.dart';
import 'package:game_controller/presentation/utils/snackbar_collection.dart';
import 'package:game_controller/presentation/widgets/button_painters/button_group_painter.dart';
import 'package:game_controller/presentation/utils/inherited_value.dart';


class ControllerDetailsView extends ConsumerStatefulWidget{
  const ControllerDetailsView({
    super.key,
    required this.controllerId
  });

  final String controllerId;

  @override
  ConsumerState<ControllerDetailsView> createState() => _ControllerDetailsViewState();
}

class _ControllerDetailsViewState extends ConsumerState<ControllerDetailsView> with RouteAware{
  late final RouteObserver _routeObserver;
  
  @override void initState() {
    _routeObserver = ref.read(routeOvserverProvider);
    super.initState();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      _routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    OrientationFunctionCollection.setLandscape();
    super.didPopNext();
  }

  @override
  void didPush() {
    OrientationFunctionCollection.setLandscape();
    super.didPush();
  }
  


  @override
  Widget build(BuildContext context) {
    ref.listen(
      connectionMessageProvider,
      (lastMessage,newMessage){
        final message = newMessage.value;
        if(message == null) return;
        SnackbarCollection.showConnectionMessage(
          context, 
          message,
          position: .top
        );
      }
    );
    
    if(DefaultController.isDefaultById(widget.controllerId)){
      return Scaffold(
        body: onData(
          context, 
          DefaultController.getDefaultControllerById(widget.controllerId)
        )
      );  
    }

    final controllerDetails = ref.watch( 
      controllerDetailsProvider(widget.controllerId)
    );

    return Scaffold(
      body: controllerDetails.when(
        data: (state) => onData(context, state.controller), 
        error: (_ ,_) => errorWidget(context), 
        loading: (  ) => loadingWidget(context)
      ),
    );   
  } 


  Widget onData(BuildContext context, Controller controller){    
    
    return InheritedValue<String>(
      value: widget.controllerId, 
      
      child: Stack(
        children: [


          for(final posGroup in controller.buttonGroups)
          Align(
            alignment: AlignmentGeometry.xy(
              2 * (posGroup.relativePosition.dx - 0.5), 
              2 * (posGroup.relativePosition.dy - 0.5)               
            ),
            child: ButtonGroupPainter(buttonGroup: posGroup.buttonGroup),
          ),

          Align( 
            alignment: .topLeft, 
            child: MyAppBar(controller: controller,),),
        
          Align( 
            alignment: .topRight, 
            child: StatusIndicators(),),
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
