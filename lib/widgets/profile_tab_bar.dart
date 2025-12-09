import 'package:flutter/material.dart';

class ProfileTabBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final ValueChanged<int> onTap;

  const ProfileTabBar({
    Key? key,
    required this.height,
    required this.onTap,
  }) : super(key: key);

  @override
  _ProfileTabBarState createState() => _ProfileTabBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _ProfileTabBarState extends State<ProfileTabBar> {
  int _currentIndex = 0;

  final Color _selectedColor = Colors.black;
  final Color _unSelectedColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildTab('Music', 0),
          _buildTab('Performance', 1),
          _buildTab('Flow', 2),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          setState(() {
            _currentIndex = index;
            widget.onTap(index);
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: widget.height,
        child: Stack(
          children: <Widget>[
            Align(
              child: Text(
                title,
                style: TextStyle(
                    color: isSelected ? _selectedColor : _unSelectedColor,
                    fontSize: 20),
              ),
            ),
            if (isSelected)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 2,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
