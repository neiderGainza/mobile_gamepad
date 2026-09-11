import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/providers/controllers_provider.dart';
import 'package:game_controller/presentation/screens/controller_list_view/widgets/connection_header.dart';
import 'package:game_controller/presentation/screens/controller_list_view/widgets/controller_card.dart';
import 'package:go_router/go_router.dart';

class ControllerListView extends ConsumerStatefulWidget {
  const ControllerListView({super.key});

  @override
  ConsumerState<ControllerListView> createState() => _ControllerListViewState();
}

class _ControllerListViewState extends ConsumerState<ControllerListView> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
  
  
  @override
  Widget build(BuildContext context) {
    final controllers = ref.watch(controllersProvider);
    
    return Scaffold(
      body: CustomScrollView(

        slivers: [
          SliverAppBar(title: Text("Mobile Game Controller"),),

          SliverToBoxAdapter( child: const ConnectionHeader(),),

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
