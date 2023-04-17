import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/screens/home/cubit/home_cubit.dart';
import 'package:social/screens/home/cubit/home_state.dart';
import 'package:social/screens/home/home_screen.dart';

import '../../helper/component/component.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var aboutController = TextEditingController();
        var teamController = TextEditingController();

        aboutController.text = cubit.teamModel.about;
        teamController.text = cubit.teamModel.terms;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigatorTo(context, HomeScreen());
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
            ),
            title: const Text('About & Team'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          width: 50,
                          height: 50,
                          image: NetworkImage(
                            cubit.userModel!.image.toString(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      nameEdit(text: cubit.userModel!.name!, fontSize: 16),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    enabled: false,
                    controller: aboutController,
                    maxLines: 7,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(height: 2,fontSize: 12),
                    decoration: const InputDecoration(
                      label: Text('About',style: TextStyle(fontSize: 22),),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30,),

                  TextField(
                    enabled: false,
                    controller: teamController,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(height: 2,fontSize: 12),
                    decoration: const InputDecoration(
                      label: Text('Team',style: TextStyle(fontSize: 22),),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
