class LoginState {
  final bool isLoggedIn;
  final String? error;

  LoginState({this.isLoggedIn = false, this.error});

  LoginState copyWith({bool? isLoggedIn, String? error}) {
    return LoginState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      error: error ?? this.error
    );
  }
}