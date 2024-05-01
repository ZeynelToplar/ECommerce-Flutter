import 'package:flutter/material.dart';

class LoadingManagerWidget extends StatelessWidget {
  const LoadingManagerWidget({super.key,required this.child,required this.isLoading});
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if(isLoading)...[
          Container(
            color: Colors.black38.withOpacity(0.7),
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        ]
      ],
    );
  }
}
