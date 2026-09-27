import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:game_controller/core/navigation/navigation.dart';
import 'package:game_controller/data/static_collections/default_controller.dart';
import 'package:game_controller/presentation/providers/connection_message_provider.dart';
import 'package:game_controller/presentation/providers/controllers_provider.dart';
import 'package:game_controller/presentation/screens/controller_list_view/widgets/connection_header.dart';
import 'package:game_controller/presentation/screens/controller_list_view/widgets/controller_card.dart';
import 'package:game_controller/presentation/screens/controller_list_view/widgets/three_dot_menu.dart';
import 'package:game_controller/presentation/utils/orientation_function_collection.dart';
import 'package:game_controller/presentation/utils/snackbar_collection.dart';
import 'package:go_router/go_router.dart';

class ControllerListView extends ConsumerStatefulWidget {
  const ControllerListView({super.key});

  @override
  ConsumerState<ControllerListView> createState() => _ControllerListViewState();
}

class _ControllerListViewState extends ConsumerState<ControllerListView> with RouteAware{
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
    OrientationFunctionCollection.setPortrait();
    super.didPopNext();
  }

  @override
  void didPush() {
    OrientationFunctionCollection.setPortrait();
    super.didPush();
  }

  @override
  Widget build(BuildContext context) {
    final controllers = ref.watch(controllersProvider);
   
    ref.listen(
      connectionMessageProvider,
      (lastMessage,newMessage){
        final message = newMessage.value;
        if(message == null) return;
        SnackbarCollection.showConnectionMessage(context, message);
      }
    );


    return Scaffold(
      body: CustomScrollView(

        slivers: [
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.appName),
            actions: [
              const ThreeDotMenu()
            ],
          ),

          SliverToBoxAdapter( child: const ConnectionHeader(),),

          SliverToBoxAdapter(
            child: ControllerCard(controller: DefaultController.defaultController),
          ),

          SliverList.builder(
            itemCount: controllers.length,
            itemBuilder: (context, index) 
              => ControllerCard(controller: controllers[index]),
          ),
        ]
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('controller/form'),
        child: Icon(Icons.add),
      ),

    );
  }

}
