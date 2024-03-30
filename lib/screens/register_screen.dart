import 'package:flutter/material.dart';
import 'package:game_review/controllers/auth_controller.dart';
import 'package:game_review/utilities/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

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

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: h),
        child: Column(
          children: [

            //header text
            Text(
              'Register an Account',
              style: GoogleFonts.inter(
                fontSize: 24.0,
                color: const Color(0xFF15224F),
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: size.height * 0.04),

            Form(
              key: authCtr.registerFormKey,
              child: Column(
                children: [
                  emailTextField(size),
                  SizedBox(height: size.height * 0.01),
                  nameTextField(size),
                  SizedBox(height: size.height * 0.01),
                  usernameTextField(size),
                  SizedBox(height: size.height * 0.01),
                  passwordTextField(size),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),

            //sign in button
            registerButton(size),
            SizedBox(height: size.height * 0.02),

            //footer section. sign up text here
            footerText(),
            SizedBox(height: size.height * 0.07),
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
        labelText: 'Email*',
        labelStyle: GoogleFonts.inter(
          fontSize: 12.0,
          color: const Color(0xFF969AA8),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textFieldType: TextFieldType.EMAIL,
      validator: (String? v) {
        if (v == null || v.isEmpty) {
          return 'Email is required';
        }
        return null;
      },
      onChanged: (String v) {
        authCtr.rEmail = v;
      },
    );
  }

  Widget usernameTextField(Size size) {
    return AppTextField(
      textStyle: GoogleFonts.inter(
        fontSize: 16.0,
        color: Colors.grey,
      ),
      cursorColor: const Color(0xFF15224F),
      decoration: InputDecoration(
        labelText: 'Username*',
        labelStyle: GoogleFonts.inter(
          fontSize: 12.0,
          color: const Color(0xFF969AA8),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textFieldType: TextFieldType.NAME,
      validator: (String? v) {
        if (v == null || v.isEmpty) {
          return 'Username is required';
        }
        return null;
      },
      onChanged: (String v) {
        authCtr.rUsername = v;
      },
    );
  }

  Widget nameTextField(Size size) {
    return AppTextField(
      textStyle: GoogleFonts.inter(
        fontSize: 16.0,
        color: Colors.grey,
      ),
      cursorColor: const Color(0xFF15224F),
      decoration: InputDecoration(
        labelText: 'Name*',
        labelStyle: GoogleFonts.inter(
          fontSize: 12.0,
          color: const Color(0xFF969AA8),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textFieldType: TextFieldType.NAME,
      validator: (String? v) {
        if (v == null || v.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
      onChanged: (String v) {
        authCtr.rName = v;
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
        labelText: 'Password*',
        labelStyle: GoogleFonts.inter(
          fontSize: 12.0,
          color: const Color(0xFF969AA8),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      textFieldType: TextFieldType.PASSWORD,
      onChanged: (String v) {
        authCtr.rPassword = v;
      },
      validator: (String? v) {
        if (v == null || v.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
    );
  }

  Widget registerButton(Size size) {
    return SizedBox(
      height: size.height / 11,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: authCtr.register,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        child: Text(
          'Register',
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
        Get.back();
      },
      child: Text.rich(
        TextSpan(
          style: GoogleFonts.inter(
            fontSize: 12.0,
            color: const Color(0xFF3B4C68),
          ),
          children: const [
            TextSpan(
              text: 'Already have an account ?',
            ),
            TextSpan(
              text: ' ',
              style: TextStyle(
                color: Color(0xFFFF5844),
              ),
            ),
            TextSpan(
              text: 'Login',
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
