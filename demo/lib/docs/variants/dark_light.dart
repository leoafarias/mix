import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/dark_mode.provider.dart';

class VariantsDarkLightExample extends HookConsumerWidget {
  const VariantsDarkLightExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mix = Mix(
      dark(
        textColor(Colors.white),
      ),
      light(
        textColor(Colors.black),
      ),
    );

    final darkMode = ref.watch(darkModeProvider.state);

    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(children: [
          const Spacer(),
          Switch(
            value: darkMode.state,
            onChanged: (value) => darkMode.state = value,
          ),
          Text(darkMode.state ? 'DARK' : 'LIGHT'),
        ]),
      ),
      const Spacer(),
      TextMix(
        'THIS IS THE TEXT',
        mix: mix,
      ),
      const Spacer(),
    ]);
  }
}
