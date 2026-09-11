import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';

final envVars = DotEnv()..load(['../.env']);

Handler middleware(Handler handler) {
  return handler
    .use( requestLogger() )
    .use( _apiKeyAuth );
}

Handler _apiKeyAuth(Handler handler){
  return (context) async {
    final request    = context.request;
    final authHeader = request.headers['x-api-key'];

    if (authHeader == null || authHeader != envVars['SERVER_API_KEY']) {      
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {'error': 'Acceso no autorizado: Header Authorization inválido'},
      );
    }

    return handler(context);
  };
}
