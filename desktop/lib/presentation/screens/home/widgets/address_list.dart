import 'package:desktop/presentation/providers/server_address_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressList extends ConsumerWidget{
  const AddressList({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresses = ref.watch(serverAddressProvider).value;

    if(addresses == null || addresses.isEmpty){
      return FittedBox(
        
        child: InstrucctionsTile());
    }

    return Column(
      crossAxisAlignment: .start,
      children: [
        const SizedBox(height: 8,),
        Text(
          "Available Address List:",
          style: Theme.of(context).textTheme.titleMedium,
        ),

        Expanded(
          child: ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
          
              return Row(
                children: [
                  Text(
                    ' - ${address.interface.interfaceName} address: ',
                    style: Theme.of(context).textTheme.bodyLarge,  
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: .scaleDown,
                      alignment: .centerStart,
                      child: Text(
                        '${address.interface.ip}:${address.port}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: .bold,
                          decoration: .underline
                        ),
                      )
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class InstrucctionsTile extends StatelessWidget {
  const InstrucctionsTile({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        const SizedBox(height: 6,),
        Text("Instruccions: ", style: tt.bodyLarge,),
        Text("1- Connect your mobile device and your computer \non the same local network."),
        Text("2- Start the server."),
        Text("3- Scan the QR Code with your mobile."),
        const SizedBox(height: 6,),
      ],
    );
  }
}