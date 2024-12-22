import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashion_assistant/screens/total_screen.dart';

class AvatarCreationScreen extends StatefulWidget {
  const AvatarCreationScreen({super.key});

  @override
  _AvatarCreationScreenState createState() => _AvatarCreationScreenState();
}

class _AvatarCreationScreenState extends State<AvatarCreationScreen> {
  Future<void> saveAvatar() async {
    String avatarData = await FluttermojiFunctions().encodeMySVGtoString();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (avatarData.isNotEmpty) {
      await prefs.setString('savedAvatar', avatarData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Your Avatar")),
      body: Column(
        children: [
          FluttermojiCircleAvatar(),
          Expanded(child: FluttermojiCustomizer()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                await saveAvatar();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TotalScreens()),
                );
              },
              child: const Text("Next"),
            ),
          ),
        ],
      ),
    );
  }
}
