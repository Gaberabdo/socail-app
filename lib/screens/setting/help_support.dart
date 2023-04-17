import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:iconforest_flat_icons_social/flat_icons_social.dart';
import 'package:social/screens/home/cubit/home_cubit.dart';
import 'package:social/screens/home/cubit/home_state.dart';
import 'package:social/screens/setting/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:iconforest_flat_icons_social/iconforest_flat_icons_social.dart';

import '../../helper/component/component.dart';
import '../home/home_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat,
          floatingActionButton: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
            ),

            child: FloatingActionButton(
              elevation: 30,
              onPressed: () {
              },
              child: const Icon(
                Icons.contact_support_outlined,
                size: 40,
              ),
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigatorTo(context, HomeScreen());
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
            ),
            title: const Text('Help & Support'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Contacts",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(50),
                  child: Container(
                    color: Colors.indigo.shade200,
                    width: double.infinity,
                    height: 650,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadiusDirectional.circular(70),
                                child: Container(
                                  width: 210,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                        'assets/images/onboard_1.jpg',
                                      )
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'To answer any question',
                            style: GoogleFonts.dosis(
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          const Text(
                            'Contact us, we are there for you all the time',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'To Add Complain Her',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.itim(
                                      fontSize: 16,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadiusDirectional.circular(150),
                                    child: Image.network(
                                      'https://assets-easycms.generadevelopment.com/zana/images/depressed.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              Container(color: Colors.black, height: 100, width: 2,),
                              Column(
                                children: [
                                  Text(
                                    'Add Support Her',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.itim(
                                      fontSize: 16,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadiusDirectional.circular(150),
                                    child: Image.network(
                                      'https://th.bing.com/th/id/R.db99b04a1cae395f82b986883dcbf529?rik=50hBxtT5JZukXA&pid=ImgRaw&r=0',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),


                            ],
                          ),


                          const Spacer(),

                          Padding(
                            padding: const EdgeInsets.only(right: 70, left: 70),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.indigo.shade500,
                                    child: IconButton(
                                        onPressed: () {
                                          var controller = WebViewController()
                                            ..loadRequest(Uri.parse(
                                                'https://www.instagram.com/gaber.50/'));
                                          navigatorTo(context,
                                              WebViewScreen(controller));
                                        },
                                        icon: const Icon(
                                          FlatIconsSocial.con_instagram,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.indigo.shade500,
                                    child: IconButton(
                                        onPressed: () {
                                          var controller = WebViewController()
                                            ..loadRequest(Uri.parse(
                                                'https://www.facebook.com/ana.zoma.14418'));
                                          navigatorTo(context,
                                              WebViewScreen(controller));
                                        },
                                        icon: const Icon(
                                          FlatIconsSocial.con_facebook,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.indigo.shade500,
                                    child: IconButton(
                                        onPressed: () {
                                          var controller = WebViewController()
                                            ..loadRequest(Uri.parse(
                                                'https://wa.link/0ki30t'));
                                          navigatorTo(context,
                                              WebViewScreen(controller));
                                        },
                                        icon: const Icon(
                                          FlatIconsSocial.con_whatsapp,
                                          size: 30,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
