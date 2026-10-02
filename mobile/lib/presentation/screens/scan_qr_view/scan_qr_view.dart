import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:game_controller/presentation/utils/dialog_collection.dart';
import 'package:game_controller/presentation/utils/snackbar_collection.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrView extends StatefulWidget {
  const ScanQrView({super.key});

  @override
  State<ScanQrView> createState() => _ScanQrViewState();
}

class _ScanQrViewState extends State<ScanQrView> {
  bool _hasFinished = false;
  bool _procesing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.scanQrTitle),
        automaticallyImplyLeading:  true,
      ),
      
      body: MobileScanner(
        onDetect: onDetect
      ),

     floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _hasFinished = true;
          context.pop(null);
        },
        label: Text(AppLocalizations.of(context)!.cancel),
      ),
    );
  }



  void onDetect(BarcodeCapture barcodes) async {
    if (_hasFinished) return;
    if (_procesing) return;
    _procesing = true;
    
    
    List<ServerAddress> serverAddreses = [];
    bool isRight = false;
    bool wrongBarcodeDetected = false;

    for(final barcode in barcodes.barcodes){
      var barcodeValue =  barcode.displayValue?.toString();
      if(barcodeValue == null ) continue;
      
      try{
        final List<ServerAddress> tempServerAddress = [];
        final rawAddressCodes = barcodeValue
          .substring(1, barcodeValue.length - 1)
          .split(',');
        
        for(final addressCode in rawAddressCodes){
          tempServerAddress.add(ServerAddress.decode(addressCode));
        }
        
        isRight = true;
        serverAddreses = tempServerAddress;
      }catch(e){
        wrongBarcodeDetected = true;
        debugPrint("Error : $e");
        continue;
      }
    }
    
    if(isRight){
      final selectedServerAddress = await DialogCollection.pickServerAddress(
        context, 
        serverAddreses
      );

      if(selectedServerAddress != null){
        _hasFinished = true;
        context.pop(selectedServerAddress);
      }
    }

    if(wrongBarcodeDetected){
      SnackbarCollection.errorSnackbar(
        context,
        AppLocalizations.of(context)!.qrFormatError,
      );
    }

    _procesing = false;
  }
}
