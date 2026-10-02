import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/player_settings_repository_impl.dart';
import 'package:game_controller/presentation/screens/app_info_view/app_info_view.dart';
import 'package:game_controller/presentation/screens/controller_details_view/controller_details_view.dart';
import 'package:game_controller/presentation/screens/controller_form_view/controller_form_view.dart';
import 'package:game_controller/presentation/screens/controller_list_view/controller_list_view.dart';
import 'package:game_controller/presentation/screens/first_launch_view/first_launch_view.dart';
import 'package:game_controller/presentation/screens/how_to/how_to_view.dart';
import 'package:game_controller/presentation/screens/scan_qr_view/scan_qr_view.dart';
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
        redirect: (context, state){
          final isFirstLaunch = ref.read(
            playerSettingsRepositoryProvider).isFirstLaunch();
          
          if(isFirstLaunch) return '/firstLaunch';
          
          return '/controllers';
        },
      ),

      GoRoute(
        path: '/controllers',
        builder: (context, state) => const ControllerListView(),
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
      
      GoRoute(
        path: '/scan',
        builder: (context, state) => const ScanQrView()
      ),

      GoRoute(
        path: '/how_to',
        builder: (context, state) => const HowToView()
      ),

      GoRoute(
        path: '/firstLaunch',
        builder: (context, state) => const FirstLaunchView(), 
      ),

    ]
  );
});