import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  double latitude = 0.0;
  double longitude = 0.0;

  getLocation() async {
    permissionControl();

    var location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude = location.latitude;
    longitude = location.longitude;
    setState(() {});
  }

  permissionControl() async {
    if (await Permission.location.isGranted) {
      print("İzin verilmiş.");
    } else {
      // Kullanıcıdan izin iste
      final status = await Permission.location.request();
      if (status.isGranted) {
        // Kullanıcı tarafından izin verildi
      } else {
        // Kullanıcı tarafından izin reddedildi
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Location \nLatitude: $latitude \nLongitude: $longitude",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  getLocation();
                },
                icon: const Icon(Icons.location_on),
                label: const Text("Get Location"))
          ],
        ),
      ),
    );
  }
}
