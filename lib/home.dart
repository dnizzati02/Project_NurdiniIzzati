import 'package:flutter/material.dart';
import 'package:auth_login/info.dart';
import 'controlling.dart';
import 'profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myRTDB = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://fir-auth-40b48-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref();

  String rssiValue = '0';
  String tempValue = '0';
  String humidityValue = '0';
  String soilMoistureValue = '0';
  String mq135Value = '0';

  int _selectedIndex = 0;

  void _readSensorValue() {
    myRTDB.child('Sensor/rssi').onValue.listen((event) {
      setState(() => rssiValue = event.snapshot.value?.toString() ?? 'No Data');
    });
    myRTDB.child('Sensor/temp').onValue.listen((event) {
      setState(() => tempValue = event.snapshot.value?.toString() ?? 'No Data');
    });
    myRTDB.child('Sensor/humidity').onValue.listen((event) {
      setState(() => humidityValue = event.snapshot.value?.toString() ?? 'No Data');
    });
    myRTDB.child('Sensor/soilMoisture').onValue.listen((event) {
      setState(() => soilMoistureValue = event.snapshot.value?.toString() ?? 'No Data');
    });
    myRTDB.child('Sensor/mq135').onValue.listen((event) {
      setState(() => mq135Value = event.snapshot.value?.toString() ?? 'No Data');
    });
  }

  @override
  void initState() {
    super.initState();
    _readSensorValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
        title: const Text('Smart Farm Dashboard', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [Color(0xff27b817), Color(0xffa2df46)],
            ),
          ),
        ),
      )
          : null,
      backgroundColor: const Color(0xfff1f8e9),
      body: _selectedIndex == 0
          ? SingleChildScrollView(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RSSI
            _gaugeCard('RSSI Signal', rssiValue, 'dBm', -100, 0, Colors.teal, [
              GaugeRange(startValue: -100, endValue: -70, color: Colors.red),
              GaugeRange(startValue: -70, endValue: -50, color: Colors.orange),
              GaugeRange(startValue: -50, endValue: 0, color: Colors.green),
            ]),

            const SizedBox(height: 8),
            const Text('Farm Monitoring',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),

            const SizedBox(height: 5),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
              children: [
                _gaugeCard('Temperature', tempValue, '°C', 0, 50, Colors.orange, [
                  GaugeRange(startValue: 0, endValue: 15, color: Colors.blue.shade300),
                  GaugeRange(startValue: 15, endValue: 30, color: Colors.green),
                  GaugeRange(startValue: 30, endValue: 50, color: Colors.red),
                ]),
                _gaugeCard('Humidity', humidityValue, '%', 0, 100, Colors.lightBlue, [
                  GaugeRange(startValue: 0, endValue: 30, color: Colors.red),
                  GaugeRange(startValue: 30, endValue: 60, color: Colors.green),
                  GaugeRange(startValue: 60, endValue: 100, color: Colors.blue),
                ]),
                _gaugeCard('Soil Moisture', soilMoistureValue, '', 0, 4095, const Color(0xFF9C6823), [
                  GaugeRange(startValue: 0, endValue: 1200, color: Colors.red),      // Dry
                  GaugeRange(startValue: 1200, endValue: 2500, color: Colors.green), // Optimal
                  GaugeRange(startValue: 2500, endValue: 4095, color: Colors.brown), // Too Wet
                ]),
                _gaugeCard('Air Quality', mq135Value, 'ppm', 0, 2500, Colors.deepPurple, [
                  GaugeRange(startValue: 0, endValue: 1000, color: Colors.green),
                  GaugeRange(startValue: 1000, endValue: 2000, color: Colors.orange),
                  GaugeRange(startValue: 2000, endValue: 2500, color: Colors.red),
                ]),
              ],
            ),
          ],
        ),
      )
          : _selectedIndex == 1
          ? const ControllingPage()
          : _selectedIndex == 2
          ? const InfoPage()
          : const ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_remote_sharp), label: 'Control'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Help'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _gaugeCard(String title, String value, String unit, double min, double max, Color color,
      List<GaugeRange> ranges) {
    double? numericValue;
    try {
      numericValue = double.parse(value);
    } catch (_) {
      numericValue = null;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 135,
              child: numericValue != null
                  ? SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: min,
                    maximum: max,
                    ranges: ranges,
                    pointers: <GaugePointer>[
                      NeedlePointer(value: numericValue),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          '$value $unit',
                          style: const TextStyle(fontSize: 11),
                        ),
                        angle: 90,
                        positionFactor: 0.8,
                      ),
                    ],
                  ),
                ],
              )
                  : const Center(
                child: Text(
                  'Waiting for data...',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
