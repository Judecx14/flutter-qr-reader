import 'package:flutter/material.dart';
import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/mapa_page.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'mapa': (_) => MapaPage(),
        },
        //Cambiar tema de la aplicación
        /*  theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.cyan,
            onPrimary: Colors.white,
            // Irrelevante en tema "light" pero obligatorios de definir por eso estan todos en grey:
            primaryVariant: Colors.cyan,
            secondary: Colors.cyan,
            secondaryVariant: Colors.cyan,
            onSecondary: Colors.cyan,
            background: Colors.cyan,
            onBackground: Colors.cyan,
            surface: Colors.cyan,
            onSurface: Colors.cyan,
            error: Colors.cyan,
            onError: Colors.cyan,
          ),
        ), */
      ),
    );
  }
}
