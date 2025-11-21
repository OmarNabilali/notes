class SignInGoogleState{}
class InitSignInGoogleState extends SignInGoogleState{}
class LoadingSignInGoogleState extends SignInGoogleState{}
class SuccessSignInGoogleState extends SignInGoogleState{}
class FailureSignInGoogleState extends SignInGoogleState{
  final String errMessage;

  FailureSignInGoogleState({required this.errMessage});
}