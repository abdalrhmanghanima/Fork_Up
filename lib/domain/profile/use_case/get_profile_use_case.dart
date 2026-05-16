import 'package:fork_up/domain/auth/entity/user_entity.dart';
import 'package:fork_up/domain/profile/repository/profile_repo.dart';

class GetProfileUseCase {
  ProfileRepo profileRepo;
  GetProfileUseCase(this.profileRepo);
  Future<UserEntity> call() {
    return profileRepo.getProfile();
  }
}
