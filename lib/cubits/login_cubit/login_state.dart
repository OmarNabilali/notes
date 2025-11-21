class LoginState{}
class InitLoginState extends LoginState{}
class LoadingLoginState extends LoginState{}
class SuccessLoginState extends LoginState{}
class FailureLoginState extends LoginState{
  final String errMessage;

  FailureLoginState({required this.errMessage});
}