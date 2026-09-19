import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/screens/app_info_view/app_info_view.dart';
import 'package:game_controller/presentation/screens/controller_details_view/controller_details_view.dart';
import 'package:game_controller/presentation/screens/controller_form_view/controller_form_view.dart';
import 'package:game_controller/presentation/screens/controller_list_view/controller_list_view.dart';
import 'package:go_router/go_router.dart';


final routeOvserverProvider = Provider<RouteObserver>((ref){
  return RouteObserver<ModalRoute>();
});

final navigationProvider = Provider<GoRouter>((ref){
  final routeOvserver = ref.read(routeOvserverProvider);
  
  return GoRouter(
    observers: [routeOvserver],

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

      GoRoute(
        path: '/app_info',
        builder: (context, state) => const AppInfoView()
      ),
    ]
  );
});