import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_c/native_toolchain_c.dart';

Future<void> main(List<String> args) async {
  await link(args, (input, output) async {
    if (input.config.code.targetOS != OS.linux) return;

    final uinputBridge = CLibrary(
      name: input.packageName,
      assetName: 'src/uinput/uinput_bridge.dart',
      sources: [
        'src/uinput_bridge.c',
      ],
    );

    await uinputBridge.link(
      input: input,
      output: output,
      linkerOptions: LinkerOptions.manual(),
    );
  });
}