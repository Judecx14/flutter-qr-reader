import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0.0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3d8bef',
          'Cancelar',
          false,
          ScanMode.QR,
        );
        //const barcodeScanRes = 'geo:25.522313349571863,-103.31793385276481';
        //En caso de que cancele
        if (barcodeScanRes == '-1') return;

        final scanListProvider = Provider.of<ScanListProvider>(
          context,
          listen: false,
        );
        //const barcodeScanRes = 'https://es.stackoverflow.com/';

        final scan = await scanListProvider.nuevoScan(barcodeScanRes);
        launchURL(context, scan);
      },
    );
  }
}
