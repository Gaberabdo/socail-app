import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social/helper/component/component.dart';
import 'package:social/screens/chat/agora.dart';
import 'package:social/screens/home/cubit/home_state.dart';

import '../home/cubit/home_cubit.dart';

String appId = AgoraManger.appId;
String token = AgoraManger.token;
String channel = AgoraManger.channelName;

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted = false;
  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomePageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
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
                  ],
                ),
              ),
            ],
          ),

        );
      },
    );
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [
      Permission.microphone,
    ].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
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
    await _engine.enableAudio();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
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
  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }
}
