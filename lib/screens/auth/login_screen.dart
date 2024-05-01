import 'package:ecommerce_flutter/constans/validator.dart';
import 'package:ecommerce_flutter/root_screen.dart';
import 'package:ecommerce_flutter/screens/auth/forget_password_screen.dart';
import 'package:ecommerce_flutter/screens/auth/register_screen.dart';
import 'package:ecommerce_flutter/services/MyAppFunctions.dart';
import 'package:ecommerce_flutter/widgets/app_name_text.dart';
import 'package:ecommerce_flutter/widgets/google_button_widget.dart';
import 'package:ecommerce_flutter/widgets/loading_manager_widget.dart';
import 'package:ecommerce_flutter/widgets/subtitle_text.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = "/LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    if(mounted){
      _emailController.dispose();
      _passwordController.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
  }

  Future<void> _loginFct() async{
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      try{
        setState(() {
          isLoading = true;
        });
        await auth.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
        Fluttertoast.showToast(msg: "Login successful.",textColor: Colors.white);
        if(!mounted){
          return;
        }
        Navigator.pushReplacementNamed(context, RootScreen.routeName);
      }on FirebaseException catch(error){
        await MyAppFunctions.showErrorOrWarningDialog(context: context, subtitle: error.message.toString(), fct: (){});
      }
      catch(e){
        await MyAppFunctions.showErrorOrWarningDialog(context: context, subtitle: e.toString(), fct: (){});
      }
      finally{
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body:  LoadingManagerWidget(
          isLoading: isLoading,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                   const SizedBox(height: 40,),
                   const AppNameTextWidget(
                    fontSize: 20,
                  ),
                   const SizedBox(height: 40,),
                   const Align(
                    alignment: Alignment.center,
                    child: TitleTextWidget(label: "Welcome Back :)"),
                  ),
                  const SizedBox(height: 20,),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Email Address",
                            prefixIcon: Icon(IconlyLight.message)
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          validator: (value) {
                            return Validators.emailValidator(value!);
                          },
                        ),
                        const SizedBox(height: 16.0,),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: "*****",
                              prefixIcon: Icon(IconlyLight.password)
                          ),
                          onFieldSubmitted: (value) async {
                            await _loginFct();
                          },
                          validator: (value) {
                            return Validators.passwordValidator(value!);
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                            },
                            child: const SubTitleTextWidget(label: "Forget Password ?",fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,textDecoration: TextDecoration.underline,fontSize: 16,),
                          ),
                        ),
                        const SizedBox(height: 16.0,),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                                ),
                                backgroundColor: Colors.green
                              ),
                              onPressed: () async{
                                await _loginFct();
                              },
                              icon: const Icon(Icons.login),
                              label: const Text("Login"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0,),
                        const SubTitleTextWidget(label: "Or"),
                        const SizedBox(height: 16.0,),
                         SizedBox(
                          height: kBottomNavigationBarHeight + 10,
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight,
                                  child: FittedBox(
                                     child: GoogleButtonWidget(),
                                  ),
                                ),
                              ),
                               const SizedBox(width: 6,),
                               Expanded(
                                 flex: 2,
                                 child: SizedBox(
                                   height: kBottomNavigationBarHeight - 17,
                                   child: ElevatedButton.icon(
                                     style: ElevatedButton.styleFrom(
                                         shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(24.0)
                                         ),
                                         backgroundColor: Colors.grey
                                     ),
                                     onPressed: () {
                                       Navigator.pushReplacementNamed(context, RootScreen.routeName);
                                     },
                                     icon: const Icon(IconlyLight.user),
                                     label: const Text("Guest"),
                                   ),
                                 ),
                               )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SubTitleTextWidget(label: "New Here ?"),
                            TextButton(
                              child: const SubTitleTextWidget(label: "Sign Up",fontStyle: FontStyle.italic,),
                              onPressed: () {
                                Navigator.pushNamed(context, RegisterScreen.routeName);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
