// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/v1/mobile_client.dart' as v1_mobile_client;

import '../routes/_middleware.dart' as middleware;

void main() async {
  final address = InternetAddress.tryParse('0.0.0.0') ?? InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  hotReload(() => createServer(address, port));
}

Future<HttpServer> createServer(InternetAddress address, int port) {
  final handler = Cascade().add(buildRootHandler()).handler;
  return serve(handler, address, port);
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/v1', (context) => buildV1Handler()(context));
  return pipeline.addHandler(router);
}

Handler buildV1Handler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/mobile_client', (context) => v1_mobile_client.onRequest(context,));
  return pipeline.addHandler(router);
}

