import 'package:desktop/presentation/providers/server_address_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrAddressIndicator extends ConsumerWidget{
  const QrAddressIndicator({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresses = ref.watch(serverAddressProvider).value;
    
    if(addresses == null || addresses.isEmpty) return SizedBox.shrink();

    return Container(
      margin: .only(left: 8),
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        borderRadius: .circular(8)
      ),
      
      child: QrImageView(
        
        data: [
          for(final address in addresses)
          [
            address.interface.interfaceName, 
            '${address.interface.ip}:${address.port}'
          ]
        ].toString(),

        size: 200,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        dataModuleStyle: QrDataModuleStyle(
          color: Theme.of(context).colorScheme.onTertiaryContainer,
          dataModuleShape: .square
        ),
        eyeStyle: QrEyeStyle(
          color: Theme.of(context).colorScheme.onTertiaryContainer,
          eyeShape: .square
        ),
      ),
    ); 
  }
}