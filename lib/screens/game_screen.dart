import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_review/controllers/app_controller.dart';
import 'package:game_review/models/game_model.dart';
import 'package:game_review/utilities/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_card/image_card.dart';
import 'package:nb_utils/nb_utils.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key, required this.game});

  final GameModel game;
  final _appCtr = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double imgHeight = Get.size.width > 700 ? 260.0 : size.width * 0.55;
    double boxWidth = Get.size.width > 700 ? 500 : size.width * 0.9;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text(
          game.title.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // game
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: Get.size.width > 700 ? 1 : 5,
                  child: FillImageCard(
                    color: colorLightGray,
                    heightImage: imgHeight,
                    imageProvider: NetworkImage(game.imgUrl.toString()),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(game.title.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Divider(
                            height: 5,
                            color: colorGray,
                          ),
                        ),
                      ],
                    ),
                    description: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Avg Rating: ${game.avg.toString()}")],
                    ),
                  ),
                ),
                const Expanded(flex: 2, child: SizedBox()),
              ],
            ),

            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: boxWidth,
                      child: Center(
                        child: Text(
                          'Add Your Rating',
                          style: GoogleFonts.inter(
                            fontSize: 15.0,
                            color: const Color(0xFF15224F),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.size.height * 0.01),
                    SizedBox(
                      width: boxWidth,
                      child: Form(
                        key: _appCtr.ratingFormKey,
                        child: Column(
                          children: [
                            ratingDropdown(size),
                            SizedBox(height: size.height * 0.01),
                            commentTextField(size),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // rating
            const SizedBox(height: 8),
            Text(
              'All Ratings',
              style: GoogleFonts.inter(
                fontSize: 15.0,
                color: const Color(0xFF15224F),
                fontWeight: FontWeight.w600,
              ),
            ),

            for (int r = 0; r < game.ratings!.length; r++)
              Center(
                child: Card(
                  child: SizedBox(
                    height: 120,
                    width: boxWidth,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Username: ${game.ratings![r].user!.username.toString()}',
                                ),
                                Text('Rating: ${game.ratings![r].rating.toString()}')
                              ],
                            ),
                            const Divider(),
                            const Text('Comment: '),
                            SingleChildScrollView(child: Text(game.ratings![r].comment.toString(), style: const TextStyle(fontSize: 10),)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
          _appCtr.ratingSubmit(game.id);
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
