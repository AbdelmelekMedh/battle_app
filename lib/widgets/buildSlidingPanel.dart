import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BuildSlidingPanel extends StatelessWidget {
  const BuildSlidingPanel({
    Key? key,
    required this.scrollController,
  }) : super(key: key);
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          controller: scrollController,
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 100), //15
            buildTabBar(),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.height / 15, //50
                    child: ElevatedButton(
                      onPressed: () {
                        print('button facebook');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 30),
                          const Text(
                            "Sign up with Facebook",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 25),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.height / 15,
                    child: ElevatedButton(
                      onPressed: () {
                        print('button google');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.google,
                            size: 30,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 30),
                          const Text(
                            "Sign up with Google",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 25),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.height / 15,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/signUp');
                        print('button Mail');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.mailBulk,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 25),
                          const Text(
                            "Sign up with Email",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 25),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width / 20),
                      const Text("Already have an account?",
                          style: TextStyle(fontSize: 16, color: Colors.white70)),
                      SizedBox(width: MediaQuery.of(context).size.width / 50),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/signIn');
                          print("log in");
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

Widget buildTabBar() => Center(
      child: buildDragIcon(), //Icon(Icons.arrow_drop_up,color: Colors.black.withOpacity(0.3),),
    );

Widget buildDragIcon() => Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      width: 80,
      height: 8,
    );
