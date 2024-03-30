import 'package:flutter/material.dart';
import 'package:game_review/utilities/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  final h1 = GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: Get.width / 18);
  final h2 = GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: Get.width / 23);
  final h3 = GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: Get.width / 28);
  final h4 = GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: Get.width / 33);
  final h5 = GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: Get.width / 38);
  final h6 = GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: Get.width / 43);
  final h6Muted = GoogleFonts.inter(fontSize: Get.height / 70.0, fontWeight: FontWeight.bold, color: colorMuted);
  
  final textSmall = GoogleFonts.inter(fontSize: Get.width / 40);


  final double fontSize5 = Get.height / 168.8;
  final double fontSize11 = Get.height / 76.72;
  final double fontSize12 = Get.height / 70.33;
  final double fontSize13 = Get.height / 64.93;
  final double fontSize14 = Get.height / 60.29;
  final double fontSize16 = Get.height / 52.75;
  final double fontSize17 = Get.height / 49.65;
  final double fontSize18 = Get.height / 46.89;
}
