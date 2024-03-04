import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_clean_arch/features/login/data/repositories/login_repository_impl.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/login_response.dart';
import 'package:tdd_clean_arch/features/login/domain/entities/user.dart';
import 'package:tdd_clean_arch/features/login/domain/repositories/login_repository.dart';
import 'package:tdd_clean_arch/features/login/domain/usecases/login_use_case.dart';
import 'package:tdd_clean_arch/features/login/presentation/notifier/login_state.dart';

class LoginNotifier extends StateNotifier<LoginState>{

  final LoginUseCase loginUseCase;

  LoginNotifier(this.loginUseCase) : super(LoginState());

  Future<void> login(User user) async {
    try {
      final isSuccess = await loginUseCase(user);
      if(isSuccess) {
        state = state.copyWith(isLoggedIn: true);
      } else {
        state = state.copyWith(isLoggedIn: false, error: "Login failed");
      }
    } catch(e) {
      state = state.copyWith(error: e.toString());
    }
  }
}