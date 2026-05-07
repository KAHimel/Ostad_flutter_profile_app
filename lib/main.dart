import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        primaryColor: const Color(0xFFF4B400),
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),
      ),

      darkTheme: ThemeData.dark(),

      home: ProfilePage(
        isDarkMode: isDarkMode,
        onThemeToggle: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const ProfilePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  // Information Card
  Widget infoCard(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 35, color: const Color(0xFFF4B400)),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(subtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Social Media Icon
  Widget socialIcon(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon, size: 30),
      onPressed: () async {
        await launchUrl(Uri.parse(url));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Responsive avatar size
    double avatarRadius = screenWidth * 0.18;

    if (avatarRadius > 80) {
      avatarRadius = 80;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile Card"),
        centerTitle: true,
        backgroundColor: const Color(0xFFF4B400),

        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onThemeToggle,
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // Profile Image
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: const Color(0xFFF4B400),

              child: CircleAvatar(
                radius: avatarRadius - 4,
                backgroundImage: const AssetImage('assets/images/Profile.png'),
              ),
            ),

            const SizedBox(height: 20),

            // Name
            const Text(
              'Kowshik Ahamed Himel',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Bio
            const Text(
              'Flutter App Developer | Basic UI/UX Designer | Tech Enthusiast',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            // Info Cards
            infoCard(Icons.location_on, 'Location', 'Cumilla, Bangladesh'),

            infoCard(
              Icons.school,
              'Education',
              'B.Sc. in Computer Science and Engineering from BAIUST\nHSC in Science from ITSC\nSSC in Science from CMSC',
            ),

            infoCard(Icons.code, 'Skills', 'Flutter, Dart, UI/UX Design'),

            const SizedBox(height: 25),

            const Text(
              'Connect With Me',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Social Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                socialIcon(
                  FontAwesomeIcons.github,
                  'https://github.com/KAHimel',
                ),

                socialIcon(
                  FontAwesomeIcons.linkedin,
                  'https://www.linkedin.com/in/kowshik-ahamed-himel/',
                ),

                socialIcon(
                  FontAwesomeIcons.facebook,
                  'https://www.facebook.com/Kowshik.Ahamed.Himel/',
                ),

                socialIcon(
                  FontAwesomeIcons.instagram,
                  'https://www.instagram.com/kowshik.ahamed.himel/?hl=en',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
