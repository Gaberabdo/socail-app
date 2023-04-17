
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../helper/component/component.dart';
import '../home/home_screen.dart';

class WebViewScreen extends StatelessWidget
{

  WebViewScreen(this.controller);

  var controller = WebViewController();
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            navigatorTo(context, HomeScreen());
          },
          icon: const Icon(IconBroken.Arrow___Left_2),
        ),

      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}