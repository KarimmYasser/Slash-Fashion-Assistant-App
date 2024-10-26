import 'package:fashion_assistant/screens/cart_screen.dart';
import 'package:fashion_assistant/screens/chat_screen.dart';
import 'package:fashion_assistant/screens/favorite_screen.dart';
import 'package:fashion_assistant/screens/home_screen.dart';
import 'package:fashion_assistant/screens/profile_screen.dart';

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
