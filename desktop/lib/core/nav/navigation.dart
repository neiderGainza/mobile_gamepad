import 'dart:io';

import 'package:desktop/data/source/shared_preferences_service.dart';
import 'package:desktop/data/source/vigem_bus_service.dart';
import 'package:desktop/presentation/screens/first_launch/first_launch_view.dart';
import 'package:desktop/presentation/screens/home/home_view.dart';
import 'package:desktop/presentation/screens/vigembus_missing/vigembus_missing_view.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final navigationProvider = Provider<GoRouter>((ref) {
  final isFirstLaunch = ref
      .watch(sharedPreferencesServiceProvider)
      .isFirstLaunch();

  return GoRouter(
    
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state){
          try{
            if (Platform.isWindows && !VigemBusService.isInstalled) {
              return '/vigembus_missing';
            } 
          }catch(e){
            debugPrint(e.toString());
          }

          if(isFirstLaunch) return '/first_launch';
          return '/home';
        } 
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeView()),

      GoRoute(
        path: '/first_launch',
        builder: (context, state) => const FirstLaunchView(),
      ),
      GoRoute(
        path: '/vigembus_missing',
        builder: (context, state) => const VigembusMissingView(),
      ),
    ],
  );
});
