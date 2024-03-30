import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:game_review/models/user_model.dart';
import 'package:game_review/route/route.dart';
import 'package:game_review/services/auth_service.dart';
import 'package:game_review/utilities/app_colors.dart';
import 'package:game_review/utilities/util.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthController extends GetxController {
  UserModel user = UserModel();
  String token = '';

  final _authService = AuthService();

  // login form
  final formKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  // registration form fields
  String rEmail = '';
  String rName = '';
  String rUsername = '';
  String rPassword = '';

  // password reset form
  String resetEmail = '';

  bool isLoading = false;

  @override
  void onInit() {
    String token = getStringAsync('access_token');
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (token.isNotEmpty) {
        Get.offNamedUntil(homeScreen, (route) => false);
      }
    });

    super.onInit();
  }

  void login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (isLoading) {
      return;
    }

    isLoading = true;
    EasyLoading.show(status: 'Sign in...');

    Map body = {
      'email': email,
      'password': password,
    };
    var res = await _authService.login(body);
    var json = jsonDecode(res.body);
    isLoading = false;

    if (res.statusCode == 422) {
      String errors = Util.errorsToString(json['errors']);

      Get.snackbar(json['message'], errors, backgroundColor: colorDanger, colorText: Colors.white);
      EasyLoading.dismiss();
      return;
    }

    String token = json['data']['access_token']['token'];
    if (token.isEmpty) {
      Get.snackbar('Error', 'Login failed');
      return;
    }

    user = UserModel.fromJson(json['data']['user']);
    await setValue("access_token", token);

    EasyLoading.showSuccess(json['meta']['message']);
    EasyLoading.dismiss();

    Get.offNamedUntil(homeScreen, (route) => false);
  }

  void register() async {
    if (!registerFormKey.currentState!.validate()) {
      return;
    }
    if (isLoading) {
      return;
    }

    isLoading = true;
    EasyLoading.show(status: 'Register in progress...');

    Map body = {
      'email': rEmail,
      'name': rEmail,
      'username': rEmail,
      'password': rPassword,
    };

    var res = await _authService.register(body);
    var json = jsonDecode(res.body);
    isLoading = false;

    if (res.statusCode == 422) {
      String errors = Util.errorsToString(json['errors']);

      Get.snackbar(json['message'], errors, backgroundColor: colorDanger, colorText: Colors.white);
      EasyLoading.dismiss();
      return;
    }

    String token = json['data']['access_token']['token'];
    await setValue("access_token", token);

    user = UserModel.fromJson(json['data']);

    EasyLoading.showSuccess(json['meta']['message']);
    EasyLoading.dismiss();

    Get.offNamedUntil(homeScreen, (route) => false);
  }

  void fetchUser() async {
    var res = await _authService.fetchUser({});
    var json = jsonDecode(res);

    if (json['status'] != true) {
      Get.snackbar('Error', json['message']);
      return;
    }

    user = UserModel.fromJson(json['data']);
    update();
  }

  void logout() async {
    await setValue("token", '');
    Get.offNamedUntil(loginScreen, (route) => false);
  }
}
