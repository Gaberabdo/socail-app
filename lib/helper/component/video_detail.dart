import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:social/helper/component/component.dart';
import 'package:social/screens/news/story.dart';
import 'package:video_player/video_player.dart';

class NowPlayingVideoWidget extends StatefulWidget {
  final File url;
  final double height;

  const NowPlayingVideoWidget({
    required this.url,
    required this.height,
  });

  @override
  State<NowPlayingVideoWidget> createState() => _NowPlayingVideoWidgetState();
}

class _NowPlayingVideoWidgetState extends State<NowPlayingVideoWidget> {
  VideoPlayerController? videoPlayerController;

  late ChewieController chewieController;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    if (widget.url == null) {
      videoPlayerController = VideoPlayerController.file(widget.url)
        ..addListener(() => setState(() {}));
      await videoPlayerController!.initialize().then((value) {});
    } else {
      videoPlayerController = VideoPlayerController.file(widget.url)
        ..addListener(() => setState(() {}));
      await videoPlayerController!.initialize();
    }
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoInitialize: true,
      materialProgressColors: ChewieProgressColors(playedColor: Colors.green),
      errorBuilder: (context, message) {
        return Center(
          child: Text(message),
        );
      },
    );
  }

  @override
  void dispose() {
    chewieController.dispose();
    videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: (videoPlayerController == null)
          ? Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
            )
          : videoPlayerController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoPlayerController!.value.size.width /
                      videoPlayerController!.value.size.height,
                  child: Container(
                    color: Colors.black,
                    child: Chewie(
                      controller: chewieController,
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
    );
  }
}

class HotVideo extends StatefulWidget {
  final String url;
  final double height;

  const HotVideo({
    required this.url,
    required this.height,
  });

  @override
  State<HotVideo> createState() => _HotVideoState();
}

class _HotVideoState extends State<HotVideo> {
  VideoPlayerController? videoPlayerController;

  late ChewieController chewieController;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final fileInfo = await checkCacheFor(widget.url);
    if (fileInfo == null) {
      videoPlayerController = VideoPlayerController.network(widget.url)
        ..addListener(() => setState(() {}));
      await videoPlayerController!.initialize().then((value) {
        cachedForUrl(widget.url);
      });
    } else {
      final file = fileInfo.file;
      videoPlayerController = VideoPlayerController.file(file)
        ..addListener(() => setState(() {}));
      await videoPlayerController!.initialize();
    }
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoInitialize: true,

      materialProgressColors: ChewieProgressColors(playedColor: Colors.green),
      errorBuilder: (context, message) {
        return Center(
          child: Text(message),
        );
      },
    );
  }

  @override
  void dispose() {
    chewieController.dispose();
    videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: (videoPlayerController == null)
          ? Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
            )
          : videoPlayerController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoPlayerController!.value.size.width /
                      videoPlayerController!.value.size.height,
                  child: Container(
                    color: Colors.black,
                    child: Chewie(
                      controller: chewieController,
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
    );
  }
}

Future<FileInfo?> checkCacheFor(String url) async {
  final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
  return value;
}

void cachedForUrl(String url) async {
  await DefaultCacheManager().getSingleFile(url).then((value) {});
}
