import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class ControllingPage extends StatefulWidget {
  const ControllingPage({super.key});

  @override
  State<ControllingPage> createState() => _ControllingPageState();
}

class _ControllingPageState extends State<ControllingPage> {
  final myRTDB = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://fir-auth-40b48-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref();

  bool pumpSwitch = false;
  bool isLoading = true;

  void loadPumpStatus() {
    myRTDB.child('Actuator/pumpManual').onValue.listen((event) {
      setState(() {
        pumpSwitch = event.snapshot.value as bool? ?? false;
        isLoading = false;
      });
    });
  }

  void updatePump(bool value) {
    setState(() => isLoading = true);
    myRTDB.child('Actuator/pumpManual').set(value).then((_) {
      setState(() {
        pumpSwitch = value;
        isLoading = false;
      });
    }).catchError((error) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update: $error')),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    loadPumpStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pump Control', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xff27b817),
                Color(0xffa2df46),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xfff1f8e9),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.water_drop, color: Colors.green, size: 30),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Water Pump', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            pumpSwitch ? 'Status: ON' : 'Status: OFF',
                            style: TextStyle(color: pumpSwitch ? Colors.green : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    isLoading
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : Switch(
                      value: pumpSwitch,
                      onChanged: updatePump,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
