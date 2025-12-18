import 'package:battle_app/api/video_api.dart';
import 'package:battle_app/models/resource_file_stream_model.dart';
import 'package:battle_app/widgets/videos_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {

  final VideoApi api = VideoApi.to;

  List<ResourceFileStreamModel> videos = [];
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
      videos = await api.getFeed(page: 0, size: 20);
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
          body: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return VideosItem(
                video: videos[index],
                animationController: _animationController,
              );
            },
          ),
      );
    }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
