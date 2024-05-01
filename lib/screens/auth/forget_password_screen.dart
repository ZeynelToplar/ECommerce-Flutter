import 'package:ecommerce_flutter/constans/validator.dart';
import 'package:ecommerce_flutter/services/assets_manager.dart';
import 'package:ecommerce_flutter/widgets/app_name_text.dart';
import 'package:ecommerce_flutter/widgets/subtitle_text.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  static const routeName = "/ForgetPasswordScreen";

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  late final TextEditingController _emailController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  Future<void> _forgetPasswordFct() async{
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){

    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppNameTextWidget(fontSize: 20),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 10,),
              Image.asset(AssetsManager.forget,width: size.width*0.25,height: size.height*0.25,),
              const SizedBox(height: 10,),
              Center(child: const TitleTextWidget(label: "Forget Password ?")),
              const SizedBox(height: 10,),
              Center(child: const SubTitleTextWidget(label: "Please Enter Email address",fontSize: 14,)),
              const SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "Email Address",
                          prefixIcon: Icon(IconlyLight.message)
                      ),
                      validator: (value) {
                        return Validators.emailValidator(value!);
                      },
                    ),
                    const SizedBox(height: 30,),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(12.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                              backgroundColor: Colors.green
                          ),
                          onPressed: () async{
                            await _forgetPasswordFct();
                          },
                          icon: const Icon(Icons.send),
                          label: const Text("Send code your email"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
