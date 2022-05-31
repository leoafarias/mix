import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class MixableWidgetsCatalogBox extends StatelessWidget {
  const MixableWidgetsCatalogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Box(
        mix: Mix(
          height(100),
          width(300),
          rounded(15),
          bgColor(Colors.amber),
          align(Alignment.center),
          elevation(4), // can be 0, 1, 2, 3, 4, 6, 8, 9, 12, 16, 24
        ),
      ),
    );
  }
}
