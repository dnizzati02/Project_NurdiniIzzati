import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'academicintegrity.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  // Launches a given URL in the browser
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help & Support',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.school, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AcademicIntegrityPage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xffe8f5e9),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'FAQs',
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 10),

          // FAQ Cards
          Card(
            child: ListTile(
              leading: const Icon(Icons.sensors, color: Colors.green),
              title: Text('How do I connect to my farm sensors?',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              subtitle: Text(
                'Ensure sensors are powered and connected to Firebase. The app auto-fetches data.',
                style: GoogleFonts.poppins(),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.water_drop, color: Colors.green),
              title: Text('How can I control the irrigation pump?',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              subtitle: Text(
                'Go to the "Control" tab in the bottom nav bar to turn it on or off.',
                style: GoogleFonts.poppins(),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.green),
              title: Text('Why is the sensor showing "Loading..."?',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              subtitle: Text(
                'This usually means data is still loading or there\'s a connection issue.',
                style: GoogleFonts.poppins(),
              ),
            ),
          ),

          const SizedBox(height: 30),

          Text(
            'Video Tutorial',
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 10),

          Card(
            child: ExpansionTile(
              leading: const Icon(Icons.play_circle_fill, size: 30, color: Colors.green),
              title: Text('Watch Getting Started Guide',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This short video shows how to set up the Smart Farm app and start using its features.',
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        icon: const Icon(Icons.link, color: Colors.green),
                        label: Text(
                          'https://youtube.com/shorts/X3PP1cZaleo?si=8GryLI_LGOVrqrK4',
                          style: GoogleFonts.poppins(color: Colors.green),
                        ),
                        onPressed: () {
                          _launchURL('https://youtube.com/shorts/X3PP1cZaleo?si=8GryLI_LGOVrqrK4');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Text(
            'Contact Support',
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 10),

          Card(
            child: ListTile(
              leading: const Icon(Icons.email, color: Colors.green),
              title: Text('Email', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              subtitle: Text('dnizzati@smartfarm.com', style: GoogleFonts.poppins()),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: Text('Phone', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              subtitle: Text('+6011-56695635', style: GoogleFonts.poppins()),
            ),
          ),
        ],
      ),
    );
  }
}
