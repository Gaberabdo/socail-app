import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/helper/component/component.dart';
import 'package:social/model/chat_model.dart';
import 'package:social/model/search_model.dart';
import 'package:social/model/user_model.dart';
import 'package:social/screens/chat/chat_screen.dart';
import 'package:social/screens/home/cubit/home_cubit.dart';
import 'package:social/screens/home/cubit/home_state.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildUser(
                        HomeCubit.get(context).allUser[index], context),
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 20.0,
                          top: 10,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      );
                    },
                    itemCount: HomeCubit.get(context).allUser.length),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildUser(UserModel model, context) => InkWell(
        onTap: () {
          navigatorTo(
              context,
              ChatDetailsScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(model.image.toString()),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Text(model.name!),
            ],
          ),
        ),
      );

}
