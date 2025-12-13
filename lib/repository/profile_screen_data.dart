import 'package:battle_app/models/login_model.dart';
import 'package:battle_app/models/profile_model.dart';

class ProfileScreenData {
  final LoginResponseModel details;
  ProfileModel? profile;

  ProfileScreenData(this.details, this.profile);
}