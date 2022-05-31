import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class VariantsOrOperator extends StatelessWidget {
  const VariantsOrOperator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mix = Mix(
      padding(20.0),
      (dark | light)(
        // Whether it's small OR medium
        width(300),
        height(400),
        bgColor(Colors.white),
      ),
    );
    return Container(
      alignment: Alignment.center,
      color: Colors.black,
      child: Box(
        mix: mix,
      ),
    );
  }
}
