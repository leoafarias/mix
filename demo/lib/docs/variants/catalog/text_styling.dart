import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class VariantsTextStylingExample extends StatelessWidget {
  const VariantsTextStylingExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mix = Mix(
      mainAxis(MainAxisAlignment.center),
      title(
        titleCase(), // Makes the title uppercase
        font(
          weight: FontWeight.bold, // Makes the title bold
        ),
      ),
    );

    return Center(
      child: VBox(mix: mix, children: [
        TextMix(
          'this will be upercased and bold',
          variants: [title],
        ),
        const TextMix('but this will not'),
      ]),
    );
  }
}
