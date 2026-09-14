import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/core/navigation/navigation.dart';
import 'package:game_controller/presentation/providers/controller_edit_provider.dart';
import 'package:game_controller/presentation/screens/controller_form_view/menus/edit_menu.dart';
import 'package:game_controller/presentation/screens/controller_form_view/menus/top_menu.dart';
import 'package:game_controller/presentation/screens/controller_form_view/widgets/reative_controller_painter.dart';
import 'package:game_controller/presentation/utils/inherited_value.dart';
import 'package:game_controller/presentation/utils/orientation_function_collection.dart';


class ControllerFormView extends ConsumerStatefulWidget{
  const ControllerFormView({
    super.key,
    required this.controllerId
  });

  final String ? controllerId;

  @override
  ConsumerState<ControllerFormView> createState() => _ControllerFormViewState();
}

class _ControllerFormViewState extends ConsumerState<ControllerFormView> with RouteAware{
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

    final _ = ref.watch(controllerEditProvider(widget.controllerId)
      .select(
        (c) => (
          c.controller.name, 
          c.controller.description
        ))
    );

    return InheritedValue<String?>(
      value: widget.controllerId,
      
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onTap: (){
                ref.read(controllerEditProvider(widget.controllerId).notifier)
                  .selectGroupAndButton(null, null);
              },
            ),
      
            const ReactiveControllerPainter(),
            const Align( alignment: .topCenter, child: TopMenu()),
            const EditMenu(),
          ],
        ),
      ),
    );
  }
} 
