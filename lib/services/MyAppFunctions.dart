import 'package:ecommerce_flutter/services/assets_manager.dart';
import 'package:ecommerce_flutter/widgets/subtitle_text.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:flutter/material.dart';

class MyAppFunctions {

  static Future<void> showErrorOrWarningDialog({required BuildContext context, required String subtitle, bool isError = true, required Function fct}) async{
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                isError ? AssetsManager.error : AssetsManager.warning,
                height: 60,
                width: 60,
              ),
              const SizedBox(height: 16.0,),
              SubTitleTextWidget(label: subtitle,fontWeight: FontWeight.w600,),
              const SizedBox(height: 16.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: !isError,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const SubTitleTextWidget(label: "Cancel",color: Colors.red,),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fct();
                      Navigator.pop(context);
                    },
                    child: const SubTitleTextWidget(label: "Ok",color: Colors.green,),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> imagePickerDialog({required BuildContext context,required Function cameraFct,required Function galleryFct,required Function removeFct}) async {
    await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title:  const Center(
          child: TitleTextWidget(label: "Choose option"),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              TextButton.icon(
                onPressed: () {
                  cameraFct();
                  if(Navigator.canPop(context)){
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.camera),
                label: const Text("Camera")
              ),
              TextButton.icon(
                  onPressed: () {
                    galleryFct();
                    if(Navigator.canPop(context)){
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("Gallery")
              ),
              TextButton.icon(
                  onPressed: () {
                    removeFct();
                    if(Navigator.canPop(context)){
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Remove")
              ),
            ],
          ),
        ),
      );
    },);
  }

}