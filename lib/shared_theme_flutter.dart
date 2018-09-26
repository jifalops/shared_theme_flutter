/// Flutter plugin to easily share a theme between Flutter and the web.
///
/// It is recommended you import this library using 'as': `import ... as themer;`.
library shared_theme_flutter;

import 'package:flutter/material.dart';
import 'package:shared_theme/shared_theme.dart' as sh;
import 'package:shared_theme_flutter/src/util.dart';

// Exporting shared_theme causes the documentation to be combined on pub,
// but not exporting requires Flutter users to import both separately, each
// with their own name (`as themer` and `as ...`).
export 'package:shared_theme/shared_theme.dart';
export 'package:shared_theme_flutter/src/util.dart';

/// Sets the current theme, which is used by [primaryButton()], [secondaryButton()],
/// [tertiaryButton()], and [wrapInput()].
void setTheme(sh.Theme theme) => _currentTheme = theme;
sh.Theme get currentTheme => _currentTheme;
sh.Theme _currentTheme;

/// Transform a shared_theme's Theme into Flutter's ThemeData.
ThemeData themeData(sh.Theme t, [TargetPlatform platform]) {
  final base = t.brightness == sh.Brightness.light
      ? ThemeData.light()
      : ThemeData.dark();
  return base.copyWith(
    platform: platform ?? base.platform,
    primaryColor: colorOf(t.colors.primary, base.primaryColor),
    primaryColorLight: colorOf(t.colors.primaryLight, base.primaryColorLight),
    primaryColorDark: colorOf(t.colors.primaryDark, base.primaryColorDark),
    accentColor: colorOf(t.colors.secondary, base.accentColor),
    indicatorColor: colorOf(t.colors.indicator, base.indicatorColor),
    backgroundColor: colorOf(t.colors.background, base.backgroundColor),
    scaffoldBackgroundColor:
        colorOf(t.colors.scaffold, base.scaffoldBackgroundColor),
    cardColor: colorOf(t.colors.card, base.cardColor),
    dialogBackgroundColor: colorOf(t.colors.dialog, base.dialogBackgroundColor),
    dividerColor: colorOf(t.colors.divider, base.dividerColor),
    errorColor: colorOf(t.colors.error, base.errorColor),
    textSelectionColor:
        colorOf(t.colors.textSelection, base.textSelectionColor),
    textSelectionHandleColor:
        colorOf(t.colors.textSelectionHandle, base.textSelectionHandleColor),

    /// Default color for [RaisedButton]s
    buttonColor: color(t.elements.primaryButton.color, base.buttonColor),
    buttonTheme: buttonTheme(t, t.elements.primaryButton, base.buttonTheme),
    inputDecorationTheme:
        inputDecorationTheme(t.elements.inputBase, base.inputDecorationTheme),
    textTheme: textTheme(base.textTheme, t),
    primaryTextTheme: textTheme(base.primaryTextTheme, t),
    accentTextTheme: textTheme(base.accentTextTheme, t),

    selectedRowColor: colorOf(t.colors.selectedRow, base.selectedRowColor),
    highlightColor: colorOf(t.colors.highlight, base.highlightColor),
    hintColor: colorOf(t.colors.hint, base.hintColor),
    splashColor: colorOf(t.colors.splash, base.splashColor),
  );
}

/// Get the current theme's primary button, using [text] if [child] is null.
Widget primaryButton(void Function() onPressed, {String text, Widget child}) {
  return buttonWidget(currentTheme.elements.primaryButton, onPressed,
      child: child, text: text);
}

/// Get the current theme's secondary button, using [text] if [child] is null.
Widget secondaryButton(void Function() onPressed, {String text, Widget child}) {
  return buttonWidget(currentTheme.elements.secondaryButton, onPressed,
      child: child, text: text);
}

/// Get the current theme's tertiary button, using [text] if [child] is null.
Widget tertiaryButton(void Function() onPressed, {String text, Widget child}) {
  return buttonWidget(currentTheme.elements.tertiaryButton, onPressed,
      child: child, text: text);
}

/// Wrap a widget in padding if [currentTheme.elements.inputBase.margin] is
/// non-zero.
Widget wrapInput(Widget input) =>
    wrap(input, currentTheme.elements.inputBase.margin);
