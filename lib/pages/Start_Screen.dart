import 'package:battle_app/api/video_api.dart';
import 'package:battle_app/models/video_model.dart';
import 'package:battle_app/widgets/buildSlidingPanel.dart';
import 'package:battle_app/widgets/video_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Start_Screen extends StatefulWidget {
  @override
  State<Start_Screen> createState() => _Start_ScreenState();
}

class _Start_ScreenState extends State<Start_Screen>
    with SingleTickerProviderStateMixin {

  final VideoApi api = VideoApi.to;

  List<VideoModel> videos = [];
  bool isLoading = true;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10))
      ..repeat();

    _loadVideos();
  }

  Future<void> _loadVideos() async {
    try {
      videos = await api.fetchPublicVideos();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SlidingUpPanel(
        color: Colors.white.withOpacity(0.25),
        minHeight: MediaQuery.of(context).size.width / 2.5,
        panelBuilder: (scrollController) =>
            BuildSlidingPanel(scrollController: scrollController),
        borderRadius:
        const BorderRadius.vertical(top: Radius.circular(10)),
        body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return VideoItem(
              video: videos[index],
              animationController: _animationController,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
