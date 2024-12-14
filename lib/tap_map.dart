import 'package:fashion_assistant/screens/brand_mode/brand_add_product_screen.dart';
import 'package:fashion_assistant/screens/brand_mode/brand_mode_screen.dart';
import 'package:fashion_assistant/screens/brand_mode/brand_profile_screen.dart';
import 'package:fashion_assistant/screens/cart/cart_screen.dart';
import 'package:fashion_assistant/screens/chat_screen.dart';
import 'package:fashion_assistant/screens/favorite_screen.dart';
import 'package:fashion_assistant/screens/home_screen.dart';
import 'package:fashion_assistant/screens/personalization/profile_screen.dart';

bool inHome = true;
bool isMale = true;
const String baseURL = 'https://2eb7-156-174-3-169.ngrok-free.app';
Future<String>? kChatId;
final List<Map<String, dynamic>> screenDetails = [
  {
    'screenName': const HomeScreen(),
  },
  {
    'screenName': const FavoriteScreen(),
  },
  {
    'screenName': const ChatScreen(),
  },
  {
    'screenName': const CartScreen(),
  },
  {
    'screenName': const ProfileScreen(),
  },
];
final List<Map<String, dynamic>> screenDetailsBrand = [
  {
    'screenName': const BrandModeScreen(),
  },
  {
    'screenName': const BrandAddProductScreen(),
  },
  {
    'screenName': const BrandProfileScreen(),
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
