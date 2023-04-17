import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social/model/story_model.dart';

class StoryDetails extends StatefulWidget {
  const StoryDetails({Key? key, required this.storyModel}) : super(key: key);
  final StoryModel storyModel;

  @override
  State<StoryDetails> createState() => _StoryDetailsState();
}

class _StoryDetailsState extends State<StoryDetails> {
  double percent = 0;
  Timer? timer;
  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 3), (timer) {
      setState(() {
        percent += 0.001;
        if (percent > 1) {
          timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.storyModel.object.toString()),
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 36,
                horizontal: 8,
              ),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: percent,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(widget.storyModel.image.toString()),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.storyModel.name.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
