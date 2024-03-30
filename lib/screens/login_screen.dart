import 'package:flutter/material.dart';
import 'package:game_review/controllers/auth_controller.dart';
import 'package:game_review/route/route.dart';
import 'package:game_review/utilities/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final authCtr = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.97,
            child: Column(
              children: [
                //to give space from top
                const Expanded(
                  flex: 1,
                  child: Center(),
                ),

                //page content here
                Expanded(
                  flex: 9,
                  child: buildCard(size),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard(Size size) {
    var h = Get.size.width > 700 ? Get.size.width * 0.35 : Get.size.width * 0.05;

    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: h),
        child: Column(
          children: <Widget>[
            //logo section
            SizedBox(
              height: size.height * 0.07,
            ),
            //header text
            Text(
              'Login Account',
              style: GoogleFonts.inter(
                fontSize: 24.0,
                color: const Color(0xFF15224F),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: size.height * 0.10,
            ),
            Form(
              key: authCtr.formKey,
              child: Column(
                children: [
                  //email & password section
                  emailTextField(size),
                  SizedBox(height: size.height * 0.02),
                  passwordTextField(size),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),

            //sign in button
            signInButton(size),
            SizedBox(
              height: size.height * 0.04,
            ),

            //footer section. sign up text here
            footerText(),
          ],
        ),
      ),
    );
  }

  Widget emailTextField(Size size) {
    return AppTextField(
      textStyle: GoogleFonts.inter(
        fontSize: 16.0,
        color: Colors.grey,
      ),
      cursorColor: const Color(0xFF15224F),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: GoogleFonts.inter(
          fontSize: 12.0,
          color: const Color(0xFF969AA8),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textFieldType: TextFieldType.EMAIL,
      onChanged: (String v) {
        authCtr.email = v;
      },
    );
  }

  Widget passwordTextField(Size size) {
    return AppTextField(
      textStyle: GoogleFonts.inter(
        fontSize: 16.0,
        color: const Color(0xFF15224F),
      ),
      cursorColor: const Color(0xFF15224F),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: GoogleFonts.inter(
          fontSize: 12.0,
          color: const Color(0xFF969AA8),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textFieldType: TextFieldType.PASSWORD,
      onChanged: (String v) {
        authCtr.password = v;
      },
    );
  }

  Widget signInButton(Size size) {
    return SizedBox(
      height: size.height / 11,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: authCtr.login,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        child: Text(
          'Login',
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget footerText() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(registerScreen);
      },
      child: Text.rich(
        TextSpan(
          style: GoogleFonts.inter(
            fontSize: 12.0,
            color: const Color(0xFF3B4C68),
          ),
          children: const [
            TextSpan(
              text: 'Don\'t have an account ?',
            ),
            TextSpan(
              text: ' ',
              style: TextStyle(
                color: Color(0xFFFF5844),
              ),
            ),
            TextSpan(
              text: 'Register',
              style: TextStyle(
                color: colorPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
