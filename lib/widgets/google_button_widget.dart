import 'package:ecommerce_flutter/root_screen.dart';
import 'package:ecommerce_flutter/services/MyAppFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';

class GoogleButtonWidget extends StatelessWidget{
  const GoogleButtonWidget({super.key});

  Future<void> signInWithGoogle({required BuildContext context}) async {
    try{
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();
      if(googleAccount != null){
        final googleAuth = await googleAccount.authentication;
        if(googleAuth.accessToken != null && googleAuth.idToken != null){
          final authResults = await FirebaseAuth.instance.signInWithCredential(GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
          ));
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacementNamed(context, RootScreen.routeName);
      });
    }on FirebaseException catch(e){
      await MyAppFunctions.showErrorOrWarningDialog(context: context, subtitle: e.message.toString(), fct: (){});
    }
    catch(e){
      await MyAppFunctions.showErrorOrWarningDialog(context: context, subtitle: e.toString(), fct: (){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red
      ),
      onPressed: () async{
        await signInWithGoogle(context: context);
      },
      icon: const Icon(Ionicons.logo_google),
      label: const Text("Sign in with google")
    );
  }
}
