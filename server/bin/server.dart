import 'dart:io';
import 'package:server/controller/server_controller.dart';

import '../build/bin/server.dart' as generated;



void main() async {
  final server = await generated.createServer(
    InternetAddress.anyIPv6,
    0,
  );

  await ServerController().setServer(server);
}
