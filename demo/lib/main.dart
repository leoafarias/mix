import 'package:demo/theme.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mix/mix.dart';

import 'app_shell.dart';
import 'docs/docs.dart';
import 'providers/dark_mode.provider.dart';

void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await DesktopWindow.setMinWindowSize(const Size(600, 600));
  }

  // setPathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(builder: (context, ref, _) {
        final darkMode = ref.watch(darkModeProvider);
        return MaterialApp(
          title: 'Mix Gallery',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/',
          routes: {
            '/': (context) => const AppShell(),
            // Documentation
            '/docs/headless/alert-dialog': (context) =>
                const HeadlessAlertDialogX(),
            '/docs/headless/card': (context) => const HeadlessCardX(),
            '/docs/headless/checkbox': (context) => const HeadlessCheckboxX(),
            '/docs/headless/chip': (context) => const HeadlessChipX(),
            // Documentation on https://www.fluttermix.com/docs/concepts/mixable-widgets
            '/docs/mixable_widgets/box': (context) =>
                const MixableWidgetsCatalogBox(),
            '/docs/mixable_widgets/text_mix': (context) =>
                const MixableWidgetsCatalogTextMix(),
            '/docs/mixable_widgets/pressable': (context) =>
                const MixableWidgetsCatalogPressable(),
            // Documentation on https://www.fluttermix.com/docs/concepts/variants
            '/docs/variants': (context) => const VariantsDefaultExample(),
            '/docs/variants/or': (context) => const VariantsOrOperator(),
            '/docs/variants/and': (context) => const VariantsAndOperator(),
            '/docs/variants/not': (context) => const VariantsNotOperator(),
            '/docs/variants/usage': (context) =>
                const VariantsDarkLightExample(),
            // Documentation on https://www.fluttermix.com/docs/concepts/variants#variants-catalog
            '/docs/variants/catalog/pressable': (context) =>
                const VariantsCatalogPressable(),
            '/docs/variants/catalog/text_styling': (context) =>
                const VariantsTextStylingExample(),
          },
          onUnknownRoute: (settings) {
            return PageRouteBuilder(pageBuilder: (context, _, __) {
              final theme = Theme.of(context);
              return Scaffold(
                body: Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      '404',
                      style: theme.textTheme.headline1,
                    ),
                    Text(
                      'Sorry, we couldn\'t find the page you\'re looking for :/',
                      style: theme.textTheme.subtitle2,
                    ),
                  ]),
                ),
              );
            });
          },
          builder: (context, child) {
            return MixTheme(
              data: MixThemeData(),
              child: Material(
                color: MaterialTokens.colorScheme.background.resolve(context),
                child: child ?? const SizedBox.shrink(),
              ),
            );
          },
        );
      }),
    );
  }
}
