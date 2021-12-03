import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  //Abrir el sitio web
  if (scan.tipo == 'http') {
    final url = scan.valor;
    await canLaunch(url) ? await launch(url) : throw 'No se pudo abrir $url';
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
