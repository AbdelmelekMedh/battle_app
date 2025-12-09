import 'package:battle_app/widgets/gradient_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/CategoriesScroller.dart';
import '../widgets/carousel_loading.dart';
import '../widgets/search_widget.dart';


class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          GradientContainer(),
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 10), //55
              const Center(
                child: Text(
                  ' Explore ',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              buildSearch(),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 17, 0, 10),
                child: Text('#Trends'),
              ),
              const CarouselLoading(),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('#Rap_Battle'),
                        Text('73.4 M',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.4))),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 150), //10
                    RatingBar.builder(
                      initialRating: 1,
                      minRating: 1,
                      itemCount: 1,
                      itemSize: 30.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                      ignoreGestures: true,
                    ),
                  ],
                ),
              ),
              const CategoriesScroller(),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('#Punchline'),
                    Text('73.4 M',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.4))),
                  ],
                ),
              ),
              const CategoriesScroller(),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('#Performances'),
                    Text('73.4 M',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.4))),
                  ],
                ),
              ),
              const CategoriesScroller(),
              SizedBox(height: MediaQuery.of(context).size.height / 8), //80
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search',
        onChanged: searchvideo,
      );

  void searchvideo(String query) {
    setState(() {
      this.query = query;
    });
  }
}
