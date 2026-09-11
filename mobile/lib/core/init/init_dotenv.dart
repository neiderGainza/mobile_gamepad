import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initDotenv() async{
  await dotenv.load();
}