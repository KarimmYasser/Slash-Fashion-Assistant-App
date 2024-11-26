import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashion_assistant/screens/total_screen.dart';

class AvatarCreationScreen extends StatefulWidget {
  @override
  _AvatarCreationScreenState createState() => _AvatarCreationScreenState();
}

class _AvatarCreationScreenState extends State<AvatarCreationScreen> {
  Future<void> saveAvatar() async {
    String avatarData = await FluttermojiFunctions().encodeMySVGtoString();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (avatarData.isNotEmpty) {
      await prefs.setString('savedAvatar', avatarData);
      print("##########################################");
      print("Avatar saved successfully: $avatarData");
    } else {
      print("Error: No avatar data to save.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Your Avatar")),
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
                  MaterialPageRoute(builder: (_) => TotalScreens()),
                );
              },
              child: Text("Next"),
            ),
          ),
        ],
      ),
    );
  }
}
