import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? avatarSvg;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAvatarFromBackend();
  }

  Future<void> loadAvatarFromBackend() async {
    try {
      const String apiUrl = 'api/user/get-avatar';

      final response = await HttpHelper.get(apiUrl);

      if (response['id'] != null) {
        Map<String, dynamic> avatarData = {
          "topType": response["topType"] ?? 0,
          "accessoriesType": response["accessoriesType"] ?? 0,
          "hairColor": response["hairColor"] ?? 0,
          "facialHairType": response["facialHairType"] ?? 0,
          "facialHairColor": response["facialHairColor"] ?? 0,
          "clotheType": response["clotheType"] ?? 0,
          "eyeType": response["eyeType"] ?? 0,
          "eyebrowType": response["eyebrowType"] ?? 0,
          "mouthType": response["mouthType"] ?? 0,
          "skinColor": response["skinColor"] ?? 0,
          "clotheColor": response["clotheColor"] ?? 0,
          "style": response["style"] ?? 0,
          "graphicType": response["graphicType"] ?? 0
        };

        String avatarJson = json.encode(avatarData);
        avatarSvg = await FluttermojiFunctions()
            .decodeFluttermojifromString(avatarJson);
      } else {
        throw Exception("Invalid avatar data received from backend.");
      }
    } catch (error) {
      print("Error fetching avatar: $error");
      avatarSvg = null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : avatarSvg != null && avatarSvg!.isNotEmpty
              ? SvgPicture.string(
                  avatarSvg!,
                  width: 100,
                  height: 100,
                  placeholderBuilder: (BuildContext context) =>
                      CircularProgressIndicator(),
                )
              : Text("No avatar found. Please create an avatar."),
    );
  }
}
