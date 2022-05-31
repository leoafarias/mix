import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

class MixableWidgetsCatalogTextMix extends StatelessWidget {
  const MixableWidgetsCatalogTextMix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextMix(
        'Mix is AWESOME!',
        mix: Mix(
          fontSize(16.0),
          textColor(Colors.black),
          bold(),
          textShadow(
            offset: const Offset(2.0, 2.0),
          ),
        ),
      ),
    );
  }
}
