import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:game_review/models/game_model.dart';
import 'package:game_review/route/route.dart';
import 'package:game_review/utilities/app_colors.dart';
import 'package:game_review/utilities/util.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../services/game_service.dart';

class AppController extends GetxController {
  List<GameModel> games = [];
  final _gameService = GameService();
  bool isLoading = false;

  // rating form inputs
  final ratingFormKey = GlobalKey<FormState>();
  String? rating;
  String? comment;

  @override
  void onInit() {
    getGames();
    super.onInit();
  }

  void getGames() async {
    games.clear();
    var res = await _gameService.fetchGames();

    if (res.statusCode != 200) {
      await setValue("access_token", '');
      Get.offNamedUntil(loginScreen, (route) => false);
      return;
    }

    var resJson = jsonDecode(res.body);
    for (var game in resJson['data']['games']) {
      games.add(GameModel.fromJson(game));
    }
    update();
  }

  void ratingSubmit(gameId) async {
    if (!ratingFormKey.currentState!.validate()) {
      return;
    }
    if (isLoading) {
      return;
    }

    isLoading = true;
    EasyLoading.show(status: 'Submitting...');
    var formData = {
      'game_id': gameId.toString(),
      'rating': rating,
      'comment': comment,
    };
    var res = await _gameService.ratingSubmit(formData);
    var json = jsonDecode(res.body);
    if (res.statusCode == 422) {
      String errors = Util.errorsToString(json['errors']);

      Get.snackbar(json['message'], errors, backgroundColor: colorDanger, colorText: Colors.white);
      EasyLoading.dismiss();
      return;
    }

    if (json['meta']['status'] == 'failed') {
      EasyLoading.showError(json['meta']['message']);
      EasyLoading.dismiss();
      return;
    }

    EasyLoading.showSuccess(json['meta']['message']);
    EasyLoading.dismiss();
  }
}
