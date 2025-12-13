import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SocialAction extends StatefulWidget {
  const SocialAction({Key? key}) : super(key: key);

  @override
  _SocialActionState createState() => _SocialActionState();
}

class _SocialActionState extends State<SocialAction> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FloatingActionButton(
          heroTag: "follow",
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {
            Get.toNamed('/friendProfile');
            print("FollowAction");
          },
          child: getFollowAction(),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 150), //10
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
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 150), //10
        FloatingActionButton(
          heroTag: "social 2",
          elevation: 0,
          backgroundColor: Colors.grey.withOpacity(0.8),
          onPressed: () {
            print("socialAction 2");
          },
          child: getSocialAction(
              title: '1.2M', icon: FontAwesomeIcons.solidHeart),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 150), //10
        FloatingActionButton(
          heroTag: "social 3",
          elevation: 0,
          backgroundColor: Colors.grey.withOpacity(0.8),
          onPressed: () {
            print("socialAction 3");
          },
          child: getSocialAction(
              title: '1.5K', icon: FontAwesomeIcons.solidCommentAlt),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 150), //10
        FloatingActionButton(
          heroTag: "social 4",
          elevation: 0,
          backgroundColor: Colors.grey.withOpacity(0.8),
          onPressed: () {
            print("SocialAction 4");
          },
          child: Image.asset('assets/images/output-onlinepngtools.png'),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 150), //10
        FloatingActionButton(
          heroTag: "social 5",
          elevation: 0,
          backgroundColor: Colors.grey.withOpacity(0.8),
          onPressed: () {
            print("SocialAction 5");
          },
          child: const Icon(FontAwesomeIcons.shareAlt,
              size: 25.0, color: Colors.black),
        ),
      ]),
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
        child: Icon(icon, size: 25.0, color: Colors.black),
      ),
    );
  }

  Widget getFollowAction() {
    return Stack(
      children: [_getProfilePicture(), _getPlusIcon()],
    );
  }

  Widget getSocialAction({required String title, required IconData icon}) {
    return Stack(
      children: [getIconAction(icon: icon), _getTextIcon(title: title)],
    );
  }

  Widget _getProfilePicture() {
    return Positioned(
        left: (60.0 / 2) - (50.0 / 2),
        child: Container(
            padding: const EdgeInsets.all(1.0),
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0 / 2)),
            child: CachedNetworkImage(
              imageUrl:
                  "https://secure.gravatar.com/avatar/ef4a9338dca42372f15427cdb4595ef7",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
            color: const Color.fromARGB(255, 79, 205, 247),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: const Icon(Icons.add, color: Colors.black, size: 15.0)),
    );
  }

  Widget _getTextIcon({required String title}) {
    return Positioned(
      top: 3,
      left: 0,
      child: Container(
        width: 31,
        height: 11,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(title, style: const TextStyle(fontSize: 10, color: Colors.black)),
      ),
    );
  }
}
