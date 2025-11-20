import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';
import 'custom_text_form.dart';

class CustomSigninForm extends StatefulWidget {
  const CustomSigninForm({super.key});

  @override
  State<CustomSigninForm> createState() => _CustomSigninFormState();
}

class _CustomSigninFormState extends State<CustomSigninForm> {
  TextEditingController userNameCon = TextEditingController();
  TextEditingController emailNameCon = TextEditingController();
  TextEditingController passwordNameCon = TextEditingController();

 bool isLoading=false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  Form(
        key: formKey,
        child: ListView(
          children: [
            SizedBox(height: 30),
            Center(
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSV5E74Dd_xq7-nf_PqIY97aWqynfqV1_fIQ&s',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 30,),
            Text('Register', style: TextStyle(fontSize: 22)),
            Text(
              'Enter Your Personal Information',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            Text('userName', style: TextStyle(fontSize: 18)),
      
            CustomTextForm(hintText: 'username', controller: userNameCon),
            Text('email', style: TextStyle(fontSize: 18)),
            CustomTextForm(hintText: 'email', controller: emailNameCon),
            Text('password', style: TextStyle(fontSize: 18)),
            CustomTextForm(hintText: 'password', controller: passwordNameCon),
      
            SizedBox(height: 25),
           isLoading?Center(child: CircularProgressIndicator()): CustomButton(
             color: Colors.orange,
              buttonName: Text('SignIn'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  isLoading=true;
                  setState(() {

                  });
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: emailNameCon.text,
                          password: passwordNameCon.text,
                        );
                    isLoading=false;
                    setState(() {

                    });
                    Navigator.pushReplacementNamed(context,'login' );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                    isLoading=false;
                    setState(() {

                    });
                  } catch (e) {
                    print(e);
                    isLoading=false;
                    setState(() {

                    });
                  }
                }
              },
            ),
SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Have an Account? ',style: TextStyle(fontSize: 18,),),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, 'login');
                  },

                    child: Text('Login',style: TextStyle(fontSize: 20,color: Colors.orange),))
              ],
            )
          ],
        ),

    );
  }
}
