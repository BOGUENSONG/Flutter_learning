import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class TestIcon extends StatefulWidget {
  @override
  _TestIconState createState() => _TestIconState();
}

class _TestIconState extends State<TestIcon> {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  void testBlue() {
    print("hi");
    flutterBlue.startScan();
    var subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        print('${r.device.name} found ! rssi: ${r.rssi}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hi")),
      body: Container(
          child: InkWell(
        onTap: () {
          testBlue();
        },
        child: Column(
          children: [
            Icon(Icons.school, color: Colors.black, size: 40.0),
            InkWell(
              onTap: () {
                flutterBlue.stopScan();
              },
              child: Icon(Icons.stop, color: Colors.red, size: 40.0),
            ),
          ],
        ),
      )),
    );
  }
}
