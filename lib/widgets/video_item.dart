import 'package:battle_app/models/video_model.dart';
import 'package:battle_app/widgets/video_Description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final VideoModel video;
  final AnimationController animationController;

  const VideoItem({
    super.key,
    required this.video,
    required this.animationController,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'http://10.0.2.2:8080/api/video/download/${widget.video.id}',
    )
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _controller.value.isInitialized
            ? GestureDetector(
          onTap: () {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
                isPlaying = false;
              } else {
                _controller.play();
                isPlaying = true;
              }
            });
          },
          child: SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        )
            : const Center(child: CircularProgressIndicator()),

        if (!isPlaying)
          const Center(
            child: Icon(Icons.play_arrow,
                size: 80, color: Colors.white),
          ),
        VideoDescription(authorName: widget.video.authorName,description: widget.video.description),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
