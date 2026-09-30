import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

Future<void> main(List<String> args) async {
  await link(args, (input, output) async {
    switch(input.config.code.targetOS){
      case .linux:
        final uinputBridge = CLibrary(
          name: input.packageName,
          assetName: 'src/uinput/uinput_bridge.dart',
          sources: [
            'src/uinput/uinput_bridge.c',
          ],
        );

        await uinputBridge.link(
          input: input,
          output: output,
          linkerOptions: LinkerOptions.manual(),
        );
        break;

      case .windows:

        break;
      default:
        return;
    }
  });
}