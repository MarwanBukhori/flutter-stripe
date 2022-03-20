import 'package:flutter/material.dart';
import 'package:flutter_app/services/location.service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? location;

  @override
  void initState() {
    super.initState();
    _getPosition();
  }

  _getPosition() async {
    try {
      print('Getting position');
      Position position = await getPosition();

      location = LatLng(position.latitude, position.longitude);

      setState(() {});
    } catch (e) {
      location = LatLng(2.9948629, 101.5234179);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (location == null)
      return Material(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    else
      return Material(
        child: FlutterMap(
          options: MapOptions(
            center: location,
            zoom: 12.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) {
                return Text("© OpenStreetMap contributors");
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(2.9948629, 101.5234179),
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(2.99, 101.52),
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(2.985, 101.515),
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }
}
