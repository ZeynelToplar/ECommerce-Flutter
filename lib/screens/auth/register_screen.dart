import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/constans/validator.dart';
import 'package:ecommerce_flutter/root_screen.dart';
import 'package:ecommerce_flutter/services/MyAppFunctions.dart';
import 'package:ecommerce_flutter/widgets/app_name_text.dart';
import 'package:ecommerce_flutter/widgets/image_picker_widget.dart';
import 'package:ecommerce_flutter/widgets/loading_manager_widget.dart';
import 'package:ecommerce_flutter/widgets/subtitle_text.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = "/RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool obscureText = true;
  late final TextEditingController _nameController, _emailController,_passwordController,_passwordAgainController;

  late final FocusNode _nameFocusNode, _emailFocusNode,_passwordFocusNode,_passwordAgainFocusNode;
  final _formKey = GlobalKey<FormState>();

  XFile? _pickedImage;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;
  late String userImageUrl;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController =  TextEditingController();
    _passwordController = TextEditingController();
    _passwordAgainController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordAgainFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    if(mounted){
      _nameController.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _passwordAgainController.dispose();

      _nameFocusNode.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _passwordAgainFocusNode.dispose();
    }
  }

  Future<void> _registerFct() async{
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      try{
        setState(() {
          isLoading = true;
        });
        await auth.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
        final User? user = auth.currentUser;
        final String uuid = user!.uid;
        final ref = FirebaseStorage.instance.ref().child("userImages").child("${_emailController.text.trim()}.jpg");
        await ref.putFile(File(_pickedImage!.path));
        userImageUrl = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection("users").doc(uuid).set({
          'userId' : uuid,
          'userName' : _nameController.text.trim(),
          'userImage' : userImageUrl,
          'userEmail' : _emailController.text.trim(),
          'createdDate' : Timestamp.now(),
          'userCart' : [],
          'userFavorites' : []
        });
        Fluttertoast.showToast(msg: "An account has been created.",textColor: Colors.white);
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

  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(context: context,
        cameraFct: () async {
          _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
          setState(() {

          });
        },
        galleryFct: () async {
          _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
          setState(() {

          });
        },
        removeFct: (){
          setState(() {
            _pickedImage = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
        body: LoadingManagerWidget(
          isLoading: isLoading,
          child: Padding(
          padding: const EdgeInsets.all(5.0),
            child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                const AppNameTextWidget(
                fontSize: 20,
                ),
                const SizedBox(height: 20,),
                const Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                         TitleTextWidget(label: "Welcome"),
                         SubTitleTextWidget(label: "Your Welcome message hello"),
                      ],
                    ),
                  ),
                const SizedBox(height: 40,),
                SizedBox(
                  height: size.width*0.3,
                  width: size.width*0.3,
                  child: ImagePickerWidget(
                    pickedImage: _pickedImage,
                    func: ()async{
                      await localImagePicker();
                    },
                  ),
                ),
                const SizedBox(height: 40,),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: "Full Name",
                              prefixIcon: Icon(Icons.person)
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_emailFocusNode);
                          },
                          validator: (value) {
                            return Validators.displayNameValidator(value!);
                          },
                        ),
                        const SizedBox(height: 16.0,),
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
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(IconlyLight.password),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                obscureText ? Icons.visibility : Icons.visibility_off
                              ),
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_passwordAgainFocusNode);
                          },
                          validator: (value) {
                            return Validators.passwordValidator(value!);
                          },
                        ),
                        const SizedBox(height: 16.0,),
                        TextFormField(
                          controller: _passwordAgainController,
                          focusNode: _passwordAgainFocusNode,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            hintText: "Password Again",
                            prefixIcon: const Icon(IconlyLight.password),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(
                                  obscureText ? Icons.visibility : Icons.visibility_off
                              ),
                            ),

                          ),
                          onFieldSubmitted: (value) async {
                            await _registerFct();
                          },
                          validator: (value) {
                            return Validators.passwordValidator(value!);
                          },
                        ),
                        const SizedBox(height: 48.0,),
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
                                await _registerFct();
                              },
                              icon: const Icon(Icons.person),
                              label: const Text("Sign Up"),
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
        ),
      ),
    );
  }
}
