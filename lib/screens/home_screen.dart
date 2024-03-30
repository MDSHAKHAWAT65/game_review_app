import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_review/controllers/app_controller.dart';
import 'package:game_review/controllers/auth_controller.dart';
import 'package:game_review/route/route.dart';
import 'package:game_review/utilities/app_colors.dart';
import 'package:image_card/image_card.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _appCtr = Get.put(AppController());
  final _authCtr = Get.put(AuthController());
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double imgHeight = Get.size.width > 700 ? 260.0 : 260;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text('All games', style: TextStyle(color: Colors.white)),
      ),
      key: _key,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: Get.size.width > 700 ? 2 : 3,
            child: SidebarX(
              controller: _controller,
              theme: const SidebarXTheme(
                decoration: BoxDecoration(
                  color: colorLightGray,
                ),
              ),
              items: [
                SidebarXItem(
                    icon: Icons.home,
                    label: 'Home',
                    onTap: () {
                      debugPrint('Home');
                    }),
                SidebarXItem(icon: Icons.exit_to_app, label: 'Logout', onTap: _authCtr.logout),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<AppController>(
                  builder: (ctr) {
                    return ResponsiveGridRow(
                      children: [
                
                        for(int i=0; i<ctr.games.length; i++)
                        ResponsiveGridCol(
                          xs: 12,
                          md: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FillImageCard(
                              color: colorLightGray,
                              heightImage: imgHeight,
                              imageProvider: NetworkImage(ctr.games[i].imgUrl.toString()),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ctr.games[i].title.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
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
                                children: [ElevatedButton(onPressed: () => Get.toNamed(gameScreen, arguments: {'game': ctr.games[i]}), 
                                child: const Text('View')), 
                                Expanded(child: Text("Avg Rating: ${ctr.games[i].avg.toString()}", textAlign: TextAlign.end,)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                      ],
                    );
                  }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
