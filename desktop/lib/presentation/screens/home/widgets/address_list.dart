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

    return FittedBox(
      fit: .fitHeight,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text("Instruccions: ", style: tt.bodyLarge,),
          Text("You are probably with that blond who always madde doubt.\n"
              "I know we were not perfect but ii never felt this way.\n"
              "You said for ever now i drive alone pass your street")
                
        ],
      ),
    );
  }
}