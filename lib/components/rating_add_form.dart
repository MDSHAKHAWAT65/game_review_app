import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:game_review/controllers/app_controller.dart';
import 'package:game_review/models/game_model.dart';
import 'package:game_review/utilities/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class RatingAddForm extends StatelessWidget {
  RatingAddForm({super.key, required this.gameModel});

  final _appCtr = Get.find<AppController>();
  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height * 0.97,
        child: Column(
          children: [
            //page content here
            Expanded(
              flex: 1,
              child: buildCard(size),
            ),

            for (int j = 0; j < gameModel.ratings!.length; j++)
              Column(
                children: [
                  Text(
                    gameModel.ratings![j].user!.username.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.MULTILINE,
                    enabled: false,
                    initialValue: gameModel.ratings![j].comment,
                  )
                ],
              ),
          ],
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
            const SizedBox(height: 10),
            //header text
            Text(
              'Add Your Rating',
              style: GoogleFonts.inter(
                fontSize: 20.0,
                color: const Color(0xFF15224F),
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: size.height * 0.01),

            Form(
              key: _appCtr.ratingFormKey,
              child: Column(
                children: [
                  ratingDropdown(size),
                  SizedBox(height: size.height * 0.01),
                  commentTextField(size),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            submitButton(size),
          ],
        ),
      ),
    );
  }

  Widget ratingDropdown(Size size) {
    final List<String> items = [
      '1',
      '2',
      '3',
      '4',
      '5',
    ];
    return GetBuilder<AppController>(builder: (ctr) {
      return SizedBox(
        width: 300,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: const Text(
              'Select Rating',
              style: TextStyle(
                fontSize: 14,
                color: colorDark,
              ),
            ),
            items: items
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: ctr.rating,
            onChanged: (String? value) {
              ctr.rating = value;
              ctr.update();
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      );
    });
  }

  Widget commentTextField(Size size) {
    return AppTextField(
      textStyle: GoogleFonts.inter(
        fontSize: 16.0,
        color: Colors.grey,
      ),
      cursorColor: const Color(0xFF15224F),
      decoration: InputDecoration(
        labelText: 'Comment*',
        labelStyle: GoogleFonts.inter(
          fontSize: 12.0,
          color: const Color(0xFF969AA8),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      maxLines: null,
      textFieldType: TextFieldType.MULTILINE,
      validator: (String? v) {
        if (v == null || v.isEmpty) {
          return 'Comment is required';
        }
        return null;
      },
      onChanged: (String v) {
        _appCtr.comment = v;
      },
    );
  }

  Widget submitButton(Size size) {
    return SizedBox(
      height: size.height / 11,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _appCtr.ratingSubmit(gameModel.id);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        child: Text(
          'Submit',
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

}
