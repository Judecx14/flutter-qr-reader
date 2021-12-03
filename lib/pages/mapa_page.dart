import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition puntoIncial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50,
    );

    //Marcadores

    Set<Marker> markers = <Marker>{}; //Set<Marker>();

    markers.add(
      Marker(
        markerId: const MarkerId('geo-location'),
        position: scan.getLatLng(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mapa'),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on_sharp),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  /* CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 17,
                    tilt: 50,
                  ), */
                  puntoIncial,
                ),
              );
            },
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        markers: markers,
        mapType: mapType, //Cambiar tipo de mapa
        initialCameraPosition: puntoIncial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: const Icon(Icons.layers_outlined),
        onPressed: () {
          setState(() {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }
          });
        },
      ),
    );
  }
}
