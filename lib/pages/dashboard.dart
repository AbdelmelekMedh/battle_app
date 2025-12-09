import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';

import '../repository/fake_repository.dart';
import '../widgets/music_icon.dart';
import '../widgets/social_action.dart';
import '../widgets/video_Description.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {

  late VideoPlayerController _videoPlayerController;
  bool _isPlaying = true;
  late AnimationController _animationController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.asset('videos/intro.mp4')
      ..initialize()
      ..setLooping(true)
      ..play().then((value) {
        setState(() {});
      });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation){
      return Scaffold(
          body:Stack(
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: FakeRepository.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: <Widget>[
                      _videoPlayerController.value.isInitialized
                          ? Container(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                if (_videoPlayerController
                                    .value.isPlaying) {
                                  _isPlaying = false;
                                  _videoPlayerController.pause();
                                } else {
                                  _isPlaying = true;
                                  _videoPlayerController.play();
                                }
                              });
                            },
                            child: VideoPlayer(_videoPlayerController)),
                      )
                          : Container(),
                      _isPlaying == false
                          ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.4),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Icon(
                            Icons.play_arrow,
                            size: 95,
                          ),
                        ),
                      )
                          : Container(),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              children: [
                                VideoDescription(),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MusicIcon(),
                                SocialAction(),
                              ],
                            ),
                          ]
                      ),
                    ],
                  );
                },
              ),

            ],
          ),
      );
    }
    );
  }
  @override
  void dispose() {
    _animationController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }
}
