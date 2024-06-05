import 'package:dartz/dartz.dart';

import '../../../core/enum.dart';
import '../../../core/exception/app_exceptions.dart';
import '../data_provider/profile_provider.dart';
import '../model/user_model.dart';

class ProfileRepository {
  ProfileProvider _profileProvider;

  ProfileRepository(this._profileProvider);

  Future<UserModel> getUserProfile() async {
    final res = await _profileProvider.getUserProfile();
    return UserModel.fromMap(res);
  }
}
