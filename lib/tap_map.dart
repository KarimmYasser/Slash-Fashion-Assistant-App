import 'package:fashion_assistant/screens/cart_screen.dart';
import 'package:fashion_assistant/screens/chat_screen.dart';
import 'package:fashion_assistant/screens/favorite_screen.dart';
import 'package:fashion_assistant/screens/home_screen.dart';
import 'package:fashion_assistant/screens/profile_screen.dart';

bool inHome = true;
bool isMale = true;
String baseURL =
    'https://8b80-2c0f-fc89-8032-d65f-6179-900b-c52f-3aeb.ngrok-free.app';
final List<Map<String, dynamic>> screenDetails = [
  {
    'screenName': HomeScreen(),
  },
  {
    'screenName': FavoriteScreen(),
  },
  {
    'screenName': ChatScreen(),
  },
  {
    'screenName': CartScreen(),
  },
  {
    'screenName': ProfileScreen(),
  },
];

final Map<String, Map<String, dynamic>> avatarsMap = {
  'noneChangedMale': {
    "topType": 9,
    "accessoriesType": 0,
    "hairColor": 1,
    "facialHairType": 0,
    "facialHairColor": 1,
    "clotheType": 5,
    "eyeType": 2,
    "eyebrowType": 10,
    "mouthType": 8,
    "skinColor": 1,
    "clotheColor": 6,
    "style": 0,
    "graphicType": 0
  },
  'male': {
    "topType": 9,
    "accessoriesType": 0,
    "hairColor": 1,
    "facialHairType": 0,
    "facialHairColor": 1,
    "clotheType": 5,
    "eyeType": 2,
    "eyebrowType": 10,
    "mouthType": 8,
    "skinColor": 1,
    "clotheColor": 6,
    "style": 0,
    "graphicType": 0
  },
  'noneChangedFemale': {
    "topType": 22,
    "accessoriesType": 0,
    "hairColor": 1,
    "facialHairType": 0,
    "facialHairColor": 1,
    "clotheType": 5,
    "eyeType": 2,
    "eyebrowType": 0,
    "mouthType": 8,
    "skinColor": 0,
    "clotheColor": 12,
    "style": 0,
    "graphicType": 0
  },
  'female': {
    "topType": 22,
    "accessoriesType": 0,
    "hairColor": 1,
    "facialHairType": 0,
    "facialHairColor": 1,
    "clotheType": 5,
    "eyeType": 2,
    "eyebrowType": 0,
    "mouthType": 8,
    "skinColor": 0,
    "clotheColor": 12,
    "style": 0,
    "graphicType": 0
  },
};
