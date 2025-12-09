import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF3F2F2),
            Color(0xFFF93B3B),
            Color(0xFFE7680D),
            Color(0xFF8B7C71),
          ],
        ),
      ),
    );
  }
}
