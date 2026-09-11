import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/screens/controller_details_view/controller_details_view.dart';
import 'package:game_controller/presentation/screens/controller_form_view/controller_form_view.dart';
import 'package:game_controller/presentation/screens/controller_list_view/controller_list_view.dart';
import 'package:go_router/go_router.dart';


final navigationProvider = Provider<GoRouter>((ref){
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/controllers',
      ),

      GoRoute(
        path: '/controllers',
        builder: (context, state){
          return ControllerListView();
        }
      ),
      
      GoRoute(
        path: '/controller/form',
        builder: (context, state){
          final controllerId = state.extra as String?;
          return ControllerFormView(controllerId: controllerId,);
        },
      ),

      GoRoute(
        path: '/controller/:id',
        builder: (context, state){
          final controllerId = state.pathParameters['id'];

          if(controllerId == null){
            // TODO : mostrar error, y redirigir
          }
          
          return ControllerDetailsView(controllerId: controllerId!,);
        },
      ),
    ]
  );
});