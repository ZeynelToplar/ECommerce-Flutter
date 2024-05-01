import 'package:ecommerce_flutter/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({super.key,this.backgroundColor = Colors.transparent,this.size = 20,required this.productId});

  final Color backgroundColor;
  final double size;
  final String productId;

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          elevation: 10
        ),
        onPressed: () {
          favoriteProvider.addOrRemoveFavorite(productId: widget.productId);
        },
        icon: Icon(
          favoriteProvider.isProductInFavorites(productId: widget.productId)
          ? IconlyBold.heart
          : IconlyLight.heart,
            size: widget.size,
            color: favoriteProvider.isProductInFavorites(productId: widget.productId) ? Colors.red : Colors.grey
        ),
      ),
    );
  }
}
