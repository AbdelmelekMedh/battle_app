import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialPlatform {
  final String key;
  final String label;
  final IconData icon;

  SocialPlatform(this.key, this.label, this.icon);
}

final List<SocialPlatform> socialPlatforms = [
  SocialPlatform('facebook', 'Facebook', FontAwesomeIcons.facebook),
  SocialPlatform('instagram', 'Instagram', FontAwesomeIcons.instagram),
  SocialPlatform('x', 'X (Twitter)', FontAwesomeIcons.xTwitter),
  SocialPlatform('linkedin', 'LinkedIn', FontAwesomeIcons.linkedin),
  SocialPlatform('github', 'GitHub', FontAwesomeIcons.github),
  SocialPlatform('website', 'Website', FontAwesomeIcons.globe),
];
