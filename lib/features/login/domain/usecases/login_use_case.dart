import 'package:tdd_clean_arch/features/login/domain/entities/user.dart';
import 'package:tdd_clean_arch/features/login/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  Future<bool> call(User user) async {
    bool isSuccess = false;
    final response = await loginRepository.loginUser(user);
    await response.fold((l) {
      isSuccess = false;
    }, (r) {
      isSuccess = r.success! ? true : false;
    });
    return isSuccess;
  }
}
