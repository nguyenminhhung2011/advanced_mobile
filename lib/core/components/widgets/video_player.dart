import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerUI extends StatefulWidget {
  final String url;
  final bool? autoPlay;
  final double width;
  final double height;
  const VideoPlayerUI({
    super.key,
    this.autoPlay,
    required this.url,
    required this.width,
    required this.height,
  });

  @override
  State<VideoPlayerUI> createState() => _VideoPlayerUIState();
}

class _VideoPlayerUIState extends State<VideoPlayerUI> {
  VideoPlayerController? _videoController;

  bool initialized = false;
  bool isYoutubeVideo = false;

  late YoutubePlayerController _ytbVideoController;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.url.contains('youtu.be') || widget.url.contains('youtube')) {
      isYoutubeVideo = true;
      final videoId = YoutubePlayerController.convertUrlToId(widget.url)!;
      _ytbVideoController = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: widget.autoPlay ?? false,
        params: const YoutubePlayerParams(
          showControls: false,
          strictRelatedVideos: true,
          loop: false,
          showFullscreenButton: false,
          showVideoAnnotations: false,
          enableCaption: false,
        ),
      );
      return;
    }
    // ignore: deprecated_member_use
    _videoController = VideoPlayerController.network(widget.url)
      ..initialize()
      ..setLooping(true).then((_) {
        if (mounted) {
          setState(() {
            initialized = true;
            if (widget.autoPlay ?? false) {
              _videoController?.play();
            }
          });
        }
      });
    _videoController?.addListener(_listenVideo);
  }

  void _cancelTime() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
  }

  void _startTime() {
    _cancelTime();
    _timer = Timer(const Duration(milliseconds: 150), () async {
      if (_videoController != null &&
          (_videoController?.value.isPlaying ?? false)) {
        await _videoController!.pause();
      }
      if ((await _ytbVideoController.playerState) == PlayerState.playing) {
        await _ytbVideoController.pauseVideo();
      }
    });
  }

  void _listenVideo() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    if (isYoutubeVideo) {
      _ytbVideoController.close();
    } else {
      _videoController?.removeListener(_listenVideo);
      _videoController?.dispose();
    }
    _cancelTime();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isYoutubeVideo) {
      return GestureDetector(
        onTap: () async {
          if ((await _ytbVideoController.playerState) == PlayerState.playing) {
            await _ytbVideoController.pauseVideo();
          } else {
            await _ytbVideoController.playVideo();
          }
        },
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: YoutubePlayerControllerProvider(
            controller: _ytbVideoController,
            child: Stack(
              children: [
                Positioned.fill(
                  child: YoutubePlayer(
                    controller: _ytbVideoController,
                    aspectRatio: 16 / 9,
                  ),
                ),
                Positioned.fill(
                  child: YoutubeValueBuilder(
                    builder: (context, value) {
                      return playPauseButton(
                          value.playerState == PlayerState.playing);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return Center(
      child: AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: Listener(
          onPointerDown: (_) {},
          onPointerUp: (_) {
            if (_videoController!.value.isPlaying) {
              _videoController!.pause();
            } else {
              _videoController!.play();
            }
          },
          child: Stack(
            children: [
              VideoPlayer(_videoController!),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 50),
                reverseDuration: const Duration(milliseconds: 200),
                child: playPauseButton(_videoController!.value.isPlaying),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: VideoProgressIndicator(_videoController!,
                    allowScrubbing: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget playPauseButton(bool playStatus) {
    return playStatus
        ? const SizedBox.shrink()
        : Container(
            color: Colors.black26,
            child: const Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
                semanticLabel: 'Play',
              ),
            ),
          );
  }
}
