// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:icon_broken/icon_broken.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../home/cubit/home_cubit.dart';
// import '../home/cubit/home_state.dart';
// import 'logical/agora.dart';
//
// class AudioCallScreen extends StatefulWidget {
//   const AudioCallScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AudioCallScreen> createState() => _AudioCallScreenState();
// }
//
// class _AudioCallScreenState extends State<AudioCallScreen> {
//   late int remoteUid = 0;
//   late RtcEngineEx engine;
//
//   @override
//   void initState() {
//     initAgora();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomePageStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             title: Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(
//                     HomeCubit.get(context).userModel.image.toString(),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 15.0,
//                 ),
//                 Text(
//                   HomeCubit.get(context).userModel.name.toString(),
//                   style: TextStyle(
//                       fontSize: 14,
//                       overflow: TextOverflow.clip
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     setState(() {
//                       initAgoraVideo();
//                     });
//                   },
//                   icon: Icon(IconBroken.Video))
//             ],
//           ),
//           body: Stack(
//             children: [
//               Container(
//                 child: Center(
//                   child: remoteUid == 0
//                       ? const Text(
//                           'Calling …',
//                         )
//                       : Text(
//                           'Calling with $remoteUid',
//                         ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 25.0, right: 25),
//                   child: IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop(true);
//                       },
//                       icon: const Icon(
//                         IconBroken.Call,
//                         size: 44,
//                         color: Colors.redAccent,
//                       )),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> initAgora() async {
//     await [
//       Permission.microphone,
//     ].request();
//     engine = createAgoraRtcEngineEx();
//     await engine.initialize(RtcEngineContext(appId: AgoraManger.appId));
//     await engine.enableAudio();
//     RtcEngineEventHandler(
//       onJoinChannelSuccess: (connection, elapsed) {
//         print('local user $elapsed joined successfully');
//       },
//       onUserJoined: (connection, remoteUid, elapsed) {
//         print('remote user $elapsed joined successfully');
//         setState(() => remoteUid = elapsed);
//       },
//       onUserOffline: (connection, remoteUid, reason) {
//         print('remote user $remoteUid left call');
//         setState(() => remoteUid = 0);
//         Navigator.of(context).pop(true);
//       },
//     );
//     await engine.joinChannel(
//       token: AgoraManger.token,
//       channelId: AgoraManger.channelName,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//   }
//
//   Future<void> initAgoraVideo() async {
//     await [
//       Permission.microphone,
//       Permission.camera,
//       Permission.phone,
//     ].request();
//     engine = createAgoraRtcEngineEx();
//     await engine.initialize(RtcEngineContext(
//       appId: AgoraManger.appId,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     ));
//     await engine.enableVideo();
//     RtcEngineEventHandler(
//       onJoinChannelSuccess: (connection, elapsed) {
//         print('local user $elapsed joined successfully');
//       },
//       onUserJoined: (connection, remoteUid, elapsed) {
//         print('remote user $elapsed joined successfully');
//         setState(() => remoteUid = elapsed);
//       },
//       onUserOffline: (connection, remoteUid, reason) {
//         print('remote user $remoteUid left call');
//         setState(() => remoteUid = 0);
//         Navigator.of(context).pop(true);
//       },
//     );
//     await engine.joinChannel(
//       token: AgoraManger.token,
//       channelId: AgoraManger.channelName,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//   }
// }
import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social/screens/chat/agora.dart';
import 'package:social/screens/home/cubit/home_cubit.dart';
import 'package:social/screens/home/cubit/home_state.dart';

import '../../model/user_model.dart';

String appId = AgoraManger.appId;
String token = AgoraManger.token;
String channel = AgoraManger.channelName;

class VideoCallScreen extends StatefulWidget {
   VideoCallScreen({Key? key,}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {

  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted = false;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize( RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomePageStates>(
      listener: (context, state) {},

      builder: (context, state) => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: _remoteVideo(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 100,
                      height: 150,
                      child: Center(
                        child: _localUserJoined
                            ? AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine: _engine,
                                  canvas: const VideoCanvas(uid: 0),
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                          ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: _onToggleMute,
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: muted ? Colors.purple : Colors.white,
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      muted ? Icons.mic_off : Icons.mic,
                      color: muted ? Colors.white : Colors.purple,
                      size: 20.0,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () => _onCallEnd(context),
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.redAccent,
                    padding: const EdgeInsets.all(15.0),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: _onSwitchCamera,
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(
                      Icons.switch_camera,
                      color: Colors.purple,
                      size: 20.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection:  RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Text(
        'Call..',
        textAlign: TextAlign.center,
      );
    }
  }
  void _onCallEnd(BuildContext context) {
    _engine.leaveChannel();

    Navigator.pop(context);
  }
  void _onSwitchCamera() {
    _engine.switchCamera();
  }
  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }
}
