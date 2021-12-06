import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';

const title = Var('title');

const paragraph = Var('paragraph');

class CardX extends StatelessWidget {
  const CardX({
    Key? key,
    required this.children,
    this.mix,
  }) : super(key: key);

  final List<Widget> children;
  final Mix? mix;

  Mix get __mix {
    return Mix(
      margin(20),
      elevation(6),
      rounded(10),
      padding(20),
      gap(10),
      crossAxis(CrossAxisAlignment.start),
      bgColor($surface),
      paragraph(
        textStyle($body1),
      ),
      title(
        titleCase(),
        textStyle($h6),
        font(
          weight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VBox(mix: Mix.combine(__mix, mix), children: children);
  }
}