import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:game_review/controllers/auth_controller.dart';
import 'package:game_review/route/route.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(GameReview());
}

class GameReview extends StatelessWidget {
  GameReview({super.key});

  final authCtr = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: loginScreen,
      getPages: route,
      builder: (context, myWidget) {
        myWidget = EasyLoading.init()(context, myWidget); // for multiple builder, use like this line
        return myWidget;
      },
    );
  }
}
