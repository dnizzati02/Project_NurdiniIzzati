import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AcademicIntegrityPage extends StatefulWidget {
  const AcademicIntegrityPage({super.key});

  @override
  State<AcademicIntegrityPage> createState() => _AcademicIntegrityPageState();
}

class _AcademicIntegrityPageState extends State<AcademicIntegrityPage> {
  final List<Map<String, String>> topics = [
    {
      'title': 'Flutter tutorial for beginners - login signup screens - flutter development',
      'url': 'https://youtu.be/o4h4kaRDg5Q?si=LQfkaMJCbSNmDUfl'
    },
    {
      'title': 'DFI20443 | Flutter - Pizza Menu UI Design',
      'url': 'https://youtu.be/0S1D8NWWBgo?si=l_trEgSQ9FFSl5FL'
    },
    {
      'title': 'Flutter ExpansionTile',
      'url': 'https://youtu.be/5ffk8-4v3wM?si=lIhbLHcvtoGoSBuJ'
    },
    {
      'title': 'Getting Started with the New Flutter Radial Gauge of Syncfusion',
      'url': 'https://youtu.be/2NuipO7j2tA?si=sl0Rg42IhG8NILCq'
    },
    {
      'title': 'Flutter Url Launcher | Flutter Package',
      'url': 'https://youtu.be/GhzxG9rGuWk?si=fSR7_Rf6e5obw7jO'
    },
    {
      'title': 'Bottom Navigation Bar | Flutter Step by Step Tutorial with Example',
      'url': 'https://youtu.be/2UG4rdsCZKU?si=_KROcvxESqP4lWDI'
    },
    {
      'title': 'Flutter CircleAvatar widget - Easiest way to create circular image',
      'url': 'https://youtu.be/yP8sZcmKmXA?si=sB13qrxWibx2ZZq1'
    },
    {
      'title': 'Flutter UI Tutorial | GridView UI with Animation - day 10',
      'url': 'https://youtu.be/sEXekxd_IdM?si=44hcWJlyIGVZZaYI'
    },
    {
      'title': 'Flutter YouTube Player Integration with GetX: Step-by-Step Tutorial for Beginners',
      'url': 'https://youtu.be/5SnhFr9zziw?si=vgr4WKQLLehOynsa'
    },
    {
      'title': 'How to Play YouTube Video in Flutter App || YouTube Video Player in Flutter',
      'url': 'https://youtu.be/SkoUu1vhgbg?si=bhR94xDICldeVe9i'
    },
    {
      'title': 'Switch Button In Flutter || Custom Multiple Switch || Custom Switch Buttons in Flutter',
      'url': 'https://youtu.be/UqI5SLCG0k8?si=hbHSqTRpVrRUVSLB'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Integrity', style: TextStyle(fontWeight: FontWeight.bold)),
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
      ),
      backgroundColor: const Color(0xfff1f8e9),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final item = topics[index];
          final videoId = YoutubePlayer.convertUrlToId(item['url']!);

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              title: Text(
                item['title']!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                if (videoId != null)
                  YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: videoId,
                      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
                    ),
                    showVideoProgressIndicator: true,
                    progressColors: const ProgressBarColors(
                      playedColor: Colors.green,
                      handleColor: Colors.greenAccent,
                    ),
                  ),
                const SizedBox(height: 10),
                TextButton.icon(
                  icon: const Icon(Icons.link, color: Colors.green),
                  label: Text(item['url']!, style: const TextStyle(color: Colors.green)),
                  onPressed: () {
                    // Optional: open in browser using url_launcher
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
