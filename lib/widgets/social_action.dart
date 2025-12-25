import 'package:battle_app/api/profile_api.dart';
import 'package:battle_app/controllers/comment_controller.dart';
import 'package:battle_app/models/image_profil_model.dart';
import 'package:battle_app/models/profile_model.dart';
import 'package:battle_app/models/resource_file_stream_model.dart';
import 'package:battle_app/widgets/comments_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SocialAction extends StatefulWidget {
  final ResourceFileStreamModel video;
  const SocialAction({Key? key, required this.video}) : super(key: key);

  @override
  _SocialActionState createState() => _SocialActionState();
}

class _SocialActionState extends State<SocialAction> {

  ProfileModel? profile;

  Future<void> getAuthorProfile() async {
    final result = await ProfileApi.getProfile(widget.video.authorId);
    if (!mounted) return;

    setState(() {
      profile = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAuthorProfile();
  }

  @override
  Widget build(BuildContext context) {
    final CommentController commentController =
    Get.put(CommentController(), tag: widget.video.id);

    commentController.initCount(widget.video.commentsCount);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 20,bottom: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          FloatingActionButton(
            heroTag: "follow",
            elevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () {
              Get.toNamed('/friendProfile', arguments: widget.video.authorId);
              print("FollowAction");
            },
            child: profile == null
                ? const CircularProgressIndicator(strokeWidth: 2)
                : getFollowAction(profile!.imageProfile),
          ),
          /*SizedBox(height: MediaQuery.of(context).size.height / 150), //10
          FloatingActionButton(
            heroTag: "social 1",
            elevation: 0,
            backgroundColor: Colors.grey.withOpacity(0.8),
            onPressed: () {
              Get.toNamed('/map');
              print("SocialAction 1");
            },
            child: const Icon(FontAwesomeIcons.mapMarkerAlt,
                size: 25.0, color: Colors.black),
          ),*/
          SizedBox(height: MediaQuery.of(context).size.height / 150), //10
          FloatingActionButton(
            heroTag: "Likes",
            elevation: 0,
            shape: CircleBorder(),
            backgroundColor: Colors.grey.withOpacity(0.8),
            onPressed: () {
              print("Likes Button");
            },
            child: getSocialAction(
                title: '${widget.video.likes}', icon: FontAwesomeIcons.solidHeart),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 150), //10
          FloatingActionButton(
            heroTag: "Comments",
            elevation: 0,
            shape: CircleBorder(),
            backgroundColor: Colors.grey.withOpacity(0.8),
            onPressed: () {
              commentController.loadComments(widget.video.id);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                builder: (_) => FractionallySizedBox(
                  heightFactor: 0.8,
                  child:CommentsSheet(videoId: widget.video.id),
                )
              );
            },
            child: Obx(() => getSocialAction(
              title: '${commentController.count}', icon: FontAwesomeIcons.solidCommentAlt),
            ),
          ),
          /*SizedBox(height: MediaQuery.of(context).size.height / 150), //10
          FloatingActionButton(
            heroTag: "social 4",
            elevation: 0,
            backgroundColor: Colors.grey.withOpacity(0.8),
            onPressed: () {
              print("SocialAction 4");
            },
            child: Image.asset('assets/images/output-onlinepngtools.png'),
          ),*/
          SizedBox(height: MediaQuery.of(context).size.height / 150), //10
          FloatingActionButton(
            heroTag: "Share",
            elevation: 0,
            backgroundColor: Colors.grey.withOpacity(0.8),
            shape: CircleBorder(),
            onPressed: () {
              print("Share Button");
            },
            child: const Icon(FontAwesomeIcons.shareAlt,
                size: 25.0, color: Colors.white),
          ),
        ]),
      ),
    );
  }

  Widget getIconAction({required IconData icon}) {
    return Positioned(
      left: 2.5,
      top: 5,
      child: Container(
        padding: const EdgeInsets.all(1.0),
        height: 50.0,
        width: 50.0,
        child: Icon(icon, size: 25.0, color: Colors.white),
      ),
    );
  }

  Widget getFollowAction(ImageProfile? imageProfile) {
    return Stack(
      children: [_getProfilePicture(imageProfile), _getPlusIcon()],
    );
  }

  Widget getSocialAction({required String title, required IconData icon}) {
    return Stack(
      children: [getIconAction(icon: icon), _getTextIcon(title: title)],
    );
  }

  Widget _getProfilePicture(ImageProfile? imageProfile) {
    final imageUrl = imageProfile?.filePathUrl != null
        ? 'http://10.0.2.2:8080${imageProfile!.filePathUrl}'
        : "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7" ;

    return Positioned(
        left: (60.0 / 2) - (50.0 / 2),
        child: ClipOval(
            child: CachedNetworkImage(
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              imageUrl: imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.person, size: 40),
            )));
  }

  Widget _getPlusIcon() {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 15.0)),
    );
  }

  Widget _getTextIcon({required String title}) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: 31,
        height: 15,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.6),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(child: Text(title, style: const TextStyle(fontSize: 11, color: Colors.white))),
      ),
    );
  }
}
