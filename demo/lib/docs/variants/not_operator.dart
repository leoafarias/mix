import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class VariantsNotOperator extends StatelessWidget {
  const VariantsNotOperator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mix = Mix(
      textColor(Colors.amber),
      (not(hover))(
        scale(1.2),
      ),
    );
    return Center(
      child: Pressable(
        onPressed: () {},
        child: Box(
          mix: mix,
          child: const TextMix('HOVER THIS TO CHANGE THE SCALE'),
        ),
      ),
    );
  }
}
