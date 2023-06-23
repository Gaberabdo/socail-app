abstract class RegisterState {}


class LoadingRegisterState extends RegisterState {}
class RegisterInitialState extends RegisterState {}
class SuccessRegisterState extends RegisterState {}
class ErrorRegisterState extends RegisterState {}

class SuccessCreateUserState extends RegisterState {
  final String uId;
  SuccessCreateUserState(this.uId);

}
class ErrorCreateUserState extends RegisterState {}

class ChangePasswordVisibilityState extends RegisterState {}
