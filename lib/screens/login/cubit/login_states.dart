abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final String uId ;
  SuccessLoginState(this.uId);
}

class ErrorLoginState extends LoginState {}



class ChangePasswordVisibilityState extends LoginState {}
