import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException, UserCredential, GoogleAuthProvider;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  bool isLoading = false;


  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
if(googleUser==null){
  return ;
}
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
     await FirebaseAuth.instance.signInWithCredential(credential);
     Navigator.pushReplacementNamed(context, 'home');
  }
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

              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : CustomButton(
                      color: Colors.orange,
                      buttonName: Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: () async {
                        if (formState.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                  email: emailCon.text,
                                  password: passwordCon.text,
                                );
                            isLoading = false;
                            setState(() {});
                            if (credential.user!.emailVerified) {
                              Navigator.pushReplacementNamed(context, 'home');
                            } else {
                              FirebaseAuth.instance.currentUser!.sendEmailVerification();
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title:
                                    'الرجاء التوجه لبريدك الالكتروني والضغط علي رابط التحقق',

                                btnOkOnPress: () {},
                              ).show();
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                            isLoading = false;
                            setState(() {});
                          }
                        }
                      },
                    ),
              SizedBox(height: 20),

              CustomButton(
                color: Colors.red,
                onPressed: () {
                   signInWithGoogle();
                },
                buttonName: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login With Google',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Image.asset('assets/images/google.png', height: 30),
                  ],
                ),
              ),
            ],
          ),
SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('dont have an Account? '),
              GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, 'signin');
                  },
                  child: Text('Register',style: TextStyle(color: Colors.orange,),))
              
            ],
          )
        ],
      ),
    );
  }
}
