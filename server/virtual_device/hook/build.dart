import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

Future<void> main(List<String> args) async {
  await build(args, (input, output) async {
    if(input.config.buildCodeAssets){
      final packageName = input.packageName;

      switch(input.config.code.targetOS){
        case .linux : 
          final uinputBridge = CLibrary(
            name: packageName,
            assetName: 'src/uinput/uinput_bridge.dart',
            sources: [
              'src/uinput/uinput_bridge.c',
            ]
          );  
          await uinputBridge.build(input: input, output: output);
          break;


        case .windows:
          final dll = input.packageRoot.resolve(
            'src/vigem/vigem_bridge.dll'
          );

          output.assets.code.add(
            CodeAsset(
              package: input.packageName,
              name: 'src/vigem/vigem_bridge.dart',
              linkMode: DynamicLoadingBundled(),
              file: dll,
            ),
          );
          break;

        default:
          break;
      } 
      
    }
  });
}
