import 'package:desktop/data/source/shared_preferences_singleton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>((ref){
  return SharedPreferencesServiceImpl(SharedPreferencesSingleton.instance);
});


abstract class SharedPreferencesService {
  bool isFirstLaunch();  
}

class SharedPreferencesServiceImpl implements SharedPreferencesService {
  
  const SharedPreferencesServiceImpl(this._sharedPreferences);
  
  final SharedPreferences _sharedPreferences;

  @override
  bool isFirstLaunch(){
    try{
      final result = _sharedPreferences.getBool('isFirstLaunch') 
                      ?? true;

      if(result){
        _sharedPreferences.setBool('isFirstLaunch', false);
      }

      return result;
    }catch(e){

      return true;
    }
  }
}