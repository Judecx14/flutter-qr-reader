import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_bottom_navigator_bar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final scanListProvider = Provider.of<ScanListProvider>(
    /* context,
      listen: false,
    ); */
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {
              //Sin crear variable
              Provider.of<ScanListProvider>(
                context,
                listen: false,
              ).borrarTodos();
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
        //elevation: 0.0,
        //centerTitle: true,
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Obtener el selectMenuOpt desde el provider
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    //Usar el scanListProvider

    final scanListProvider = Provider.of<ScanListProvider>(
      context,
      listen: false, //No queremes que se redubuje home page sino los otros
    );

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return const MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return const DireccionesPage();
      default:
        return const MapasPage();
    }
  }
}
