import 'package:game_review/screens/game_screen.dart';
import 'package:game_review/screens/home_screen.dart';
import 'package:game_review/screens/login_screen.dart';
import 'package:game_review/screens/register_screen.dart';
import 'package:get/get.dart';

const String loginScreen = "/";
const String registerScreen = "/register_screen";
const String homeScreen = "/home_screen";
const String gameScreen = "/game";

List<GetPage<dynamic>> route = [
  GetPage(name: loginScreen, page: () => LoginScreen()),
  GetPage(name: registerScreen, page: () => RegisterScreen()),
  GetPage(name: homeScreen, page: () => HomeScreen()),
  GetPage(name: gameScreen, page: () => GameScreen(game: Get.arguments['game'])),
];
