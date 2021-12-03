import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  const ScanTiles({Key? key, required this.tipo}) : super(key: key);

  final String tipo;

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(
            context,
            listen: false,
          ).borrarScanById(scans[i].id!);
        },
        child: ListTile(
          leading: Icon(
            tipo == 'http' ? Icons.map_outlined : Icons.directions,
            color: Theme.of(context).primaryColor, //Si cambia el context color
          ),
          title: Text(scans[i].valor),
          subtitle: Text(scans[i].id.toString()),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
          ),
          onTap: () => launchURL(context, scans[i]),
        ),
      ),
    );
  }
}
