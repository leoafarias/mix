import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class MixableWidgetsCatalogPressable extends StatefulWidget {
  const MixableWidgetsCatalogPressable({Key? key}) : super(key: key);

  @override
  State<MixableWidgetsCatalogPressable> createState() =>
      _MixableWidgetsCatalogPressableState();
}

class _MixableWidgetsCatalogPressableState
    extends State<MixableWidgetsCatalogPressable> {
  int _pressed = 0;

  @override
  Widget build(BuildContext context) {
    return VBox(mix: Mix(mainAxis(MainAxisAlignment.spaceEvenly)), children: [
      Center(
        child: Pressable(
          onPressed: () => setState(() => _pressed++),
          child: Box(
            mix: Mix(
              // when nothing's happening, bg color is the default grey
              bgColor(Colors.grey),
              (hover)(
                // when hovering, bg color is a lighter grey
                bgColor(Colors.grey.shade300),
              ),
              (press)(
                // when pressing, bg color is a darker grey
                bgColor(Colors.grey.shade600),
              ),
              rounded(8),
              padding(10),
            ),
            child: TextMix(
              'PRESS ME',
              mix: Mix(
                fontSize(18.0),
                (disabled)(
                  textColor(Colors.grey.shade900),
                ),
                textColor(Colors.black),
                bold(),
              ),
            ),
          ),
        ),
      ),
      TextMix('Pressed $_pressed times'),
    ]);
  }
}
