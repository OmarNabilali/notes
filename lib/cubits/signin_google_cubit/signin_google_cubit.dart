import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/cubits/signin_google_cubit/signin_google_state.dart';

class SignInGoogleCubit extends Cubit<SignInGoogleState>{
  SignInGoogleCubit():super(InitSignInGoogleState());


  Future<void>  loginGoogleSignIn(BuildContext context)async{
    emit(LoadingSignInGoogleState());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(SuccessSignInGoogleState());
    } catch(e){
      emit(FailureSignInGoogleState(errMessage: e.toString()));
    }
  }

}