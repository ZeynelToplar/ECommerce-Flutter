import 'package:ecommerce_flutter/widgets/subtitle_text.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:flutter/material.dart';

class EmptyBagWiget extends StatelessWidget {
  const EmptyBagWiget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.buttonText
  });

  final String imagePath,title,subTitle,buttonText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 30,),
          Image.asset(
            imagePath,
            width: double.infinity,
            height: size.height * 0.35,
          ),
          const SizedBox(height: 20,),
          const TitleTextWidget(label: "",fontSize: 40,color: Colors.red,),
          SubTitleTextWidget(label: title,fontSize: 25,fontWeight: FontWeight.w800,),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SubTitleTextWidget(label: subTitle,fontWeight: FontWeight.bold,),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15)
            ),
            child: Text(buttonText),
            onPressed: () {

            },
          )
        ],
      ),
    );
  }
}
