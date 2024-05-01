import 'package:ecommerce_flutter/screens/cart/cart_widget.dart';
import 'package:ecommerce_flutter/screens/cart/empty_bag.dart';
import 'package:ecommerce_flutter/services/assets_manager.dart';
import 'package:ecommerce_flutter/widgets/orders/order_widget.dart';
import 'package:ecommerce_flutter/widgets/title_text.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  static const routeName = "/OrderScreen";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  bool isEmptyOrders = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back_ios,size: 20,),
        ),
        title: const TitleTextWidget(label: "All Orders",fontSize: 28,),
      ),
      body: isEmptyOrders ?
            EmptyBagWiget(imagePath: AssetsManager.roundedMap, title: "No orders has been placed", subTitle: "", buttonText: 'Shop Now')
          :
            ListView.separated(
              itemBuilder: (context, index) {
                return const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2,vertical: 6),
                  child: OrdersWidget(),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.blue,
                );
              },
              itemCount: 10
            ),

    );
  }
}
