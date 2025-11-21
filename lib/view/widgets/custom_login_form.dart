import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubits/login_cubit/login_cubit.dart';
import 'package:note_app/cubits/signin_google_cubit/signin_google_cubit.dart';
import 'package:note_app/cubits/signin_google_cubit/signin_google_state.dart';

import '../../cubits/login_cubit/login_state.dart';
import 'custom_button.dart';
import 'custom_text_form.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: ListView(
        children: [
          SizedBox(height: 40),
          Center(
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJY1eH3mcBzzQb2GvPexIxUcvvBWKexaxrFw&s',
              height: 100,
              width: 100,
            ),
          ),
          Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Login to continuo using the app',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),

              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text('Email', style: TextStyle(fontSize: 18)),
              ),
              CustomTextForm(
                hintText: 'Enter your email',
                controller: emailCon,
              ),
              SizedBox(height: 15),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text('Password', style: TextStyle(fontSize: 18)),
              ),
              CustomTextForm(
                hintText: 'Enter your password',
                controller: passwordCon,
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: GestureDetector(child: Text('forget password?')),
              ),
              SizedBox(height: 25),
              BlocConsumer<LoginCubit, LoginState>(
                builder: (context, state) {
                  return state is LoadingLoginState
                      ? Center(child: CircularProgressIndicator())
                      : CustomButton(
                          color: Colors.orange,
                          buttonName: Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () async {
                            if (formState.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(
                                context,
                              ).loginEmailAndPassword(
                                context,
                                email: emailCon.text,
                                password: passwordCon.text,
                              );
                            }
                          },
                        );
                },
                listener: (context, state) {
                  if (state is SuccessLoginState) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'home',
                      (route) => false,
                    );
                  } else if (state is FailureLoginState) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,

                      desc: 'Login Failed',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    )..show();
                  }
                },
              ),
              SizedBox(height: 20),

              BlocConsumer<SignInGoogleCubit, SignInGoogleState>(
                builder: (context, state) {
                  return state is LoadingSignInGoogleState
                      ? Center(child: CircularProgressIndicator())
                      : CustomButton(
                          color: Colors.red,
                          onPressed: () {
                            BlocProvider.of<SignInGoogleCubit>(
                              context,
                            ).loginGoogleSignIn(context);
                          },
                          buttonName: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login With Google',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Image.asset(
                                'assets/images/google.png',
                                height: 30,
                              ),
                            ],
                          ),
                        );
                },
                listener: (context, state) {
                  if (state is SuccessSignInGoogleState) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'home',
                      (route) => false,
                    );
                  } else if (state is FailureSignInGoogleState) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,

                      desc: 'Google SignIn  Failed',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    )..show();
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('dont have an Account? '),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'signin');
                },
                child: Text('Register', style: TextStyle(color: Colors.orange)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
