import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BabershopLoader extends StatefulWidget {
  const BabershopLoader({super.key});

  @override
  State<BabershopLoader> createState() => _BabershopLoaderState();
}

class _BabershopLoaderState extends State<BabershopLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.twoRotatingArc(
        color: ColorsConstants.brow,
        size: 30.0,
      ),
    );
  }
}
