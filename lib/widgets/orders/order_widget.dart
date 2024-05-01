import 'package:ecommerce_flutter/constans/app_constans.dart';
import 'package:ecommerce_flutter/widgets/subtitle_text.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: FancyShimmerImage(
              height: size.width*0.25,
              width: size.width*0.25,
              imageUrl: AppConstans.imageUrl,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       const Flexible(
                        child:  TitleTextWidget(label: "Product Title",fontSize: 18,),
                      ),
                      IconButton(
                        onPressed: () {

                        },
                        icon:  const Icon(Icons.clear,color: Colors.red,size: 20,),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      TitleTextWidget(label: "Price : ",fontSize: 16,),
                      SizedBox(width: 4,),
                      Flexible(
                        child: SubTitleTextWidget(label: "\$11,00"),
                      )
                    ],
                  ),
                  const SizedBox(height: 4,),
                  const SubTitleTextWidget(label: "QTY: 20",fontSize: 14,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
