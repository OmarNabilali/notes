import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/cubits/login_cubit/login_cubit.dart';
import 'package:note_app/cubits/signin_google_cubit/signin_google_cubit.dart';
import 'package:note_app/view/screens/add_note_page.dart';
import 'package:note_app/view/screens/home_screen.dart';
import 'package:note_app/view/screens/login_page.dart';
import 'package:note_app/view/screens/signin_page.dart';
import 'package:note_app/view/test.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Notes());
}

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

      BlocProvider (create:(context) => LoginCubit(),),
        BlocProvider(create: (context) => SignInGoogleCubit(),)
      ],
      child: MaterialApp(
        routes: {
          'login': (context) => LoginPage(),
          'home': (context) => HomeScreen(),
          'signin': (context) => SigninPage(),
          'addNote': (context) => AddNotePage(),
          'test': (context) => Test(),
        },
        home:
            FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified
            ? HomeScreen()
            : LoginPage(),
      ),
    );
  }
}
