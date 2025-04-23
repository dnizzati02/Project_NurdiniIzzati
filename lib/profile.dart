import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.hammersmithOne(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
              );
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [Color(0xff27b817), Color(0xffa2df46)],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xffe8f5e9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/image.jpg'), // your image asset
                ),
                const SizedBox(height: 12),
                Text(
                  'Nurdini Izzati',
                  style: GoogleFonts.hammersmithOne(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Class: 4B', style: GoogleFonts.roboto(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Age: 20', style: GoogleFonts.roboto(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      'Education: Diploma in Electronic Engineering (IOT)',
                      style: GoogleFonts.roboto(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'University: Kolej Kemahiran Tinggi MARA Petaling Jaya',
                      style: GoogleFonts.roboto(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ExpansionTile(
                title: Text(
                  'Background Summary',
                  style: GoogleFonts.hammersmithOne(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "I'm a passionate IT student currently pursuing my Diploma in Electronic Engineering (IOT). "
                          "My interests include mobile app development, IoT integration, and data-driven solutions. "
                          "I enjoy working on smart projects that combine technology with sustainability. "
                          "I strive to build user-friendly applications that solve real-world problems.",
                      style: GoogleFonts.roboto(fontSize: 16, height: 1.6),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
