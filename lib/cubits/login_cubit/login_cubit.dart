import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/cubits/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(InitLoginState());
  loginEmailAndPassword(BuildContext context,{required String email,required String password})async{

emit(LoadingLoginState());
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (credential.user!.emailVerified) {
          Navigator.pushReplacementNamed(context, 'home');
        } else {
          FirebaseAuth.instance.currentUser!.sendEmailVerification();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            title: "Email not verified",
            desc: "Please verify your email then try again.",
          ).show();
          emit(FailureLoginState(errMessage: "Email not verified"));

        }
        emit(SuccessLoginState());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
        emit(FailureLoginState(errMessage: e.toString()));

      }
    }


    }


