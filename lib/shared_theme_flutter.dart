/// It is recommended you import this library using the `as` directive, e.g.
/// `import 'package:shared_theme_flutter/shared_theme_flutter' as themer;`
library shared_theme_flutter;

import 'package:flutter/material.dart';
import 'package:shared_theme/shared_theme.dart' as sh;
import 'package:shared_theme_flutter/src/util.dart';

export 'package:shared_theme/shared_theme.dart';
export 'package:shared_theme_flutter/src/util.dart';

/// Sets the default theme.
void setTheme(sh.Theme theme) => _currentTheme = theme;
sh.Theme get currentTheme => _currentTheme;
sh.Theme _currentTheme;

ThemeData themeData(sh.Theme t, [TargetPlatform platform]) {
  final base = t.brightness == sh.Brightness.light
      ? ThemeData.light()
      : ThemeData.dark();
  return base.copyWith(
    platform: platform ?? base.platform,
    primaryColor: getColor(t.colors.primary, base.primaryColor),
    primaryColorLight: getColor(t.colors.primaryLight, base.primaryColorLight),
    primaryColorDark: getColor(t.colors.primaryDark, base.primaryColorDark),
    accentColor: getColor(t.colors.secondary, base.accentColor),
    indicatorColor: getColor(t.colors.indicator, base.indicatorColor),
    backgroundColor: getColor(t.colors.background, base.backgroundColor),
    scaffoldBackgroundColor:
        getColor(t.colors.background, base.scaffoldBackgroundColor),
    cardColor: getColor(t.colors.surface, base.cardColor),
    dialogBackgroundColor:
        getColor(t.colors.surface, base.dialogBackgroundColor),
    dividerColor: getColor(t.colors.divider, base.dividerColor),
    errorColor: getColor(t.colors.error, base.errorColor),
    textSelectionColor:
        getColor(t.colors.primaryLight, base.textSelectionColor),
    textSelectionHandleColor:
        getColor(t.colors.primaryDark, base.textSelectionHandleColor),

    /// Default color for [RaisedButton]s
    buttonColor: color(t.elements.primaryButton.color, base.buttonColor),
    buttonTheme: buttonTheme(t, t.elements.primaryButton, base.buttonTheme),
    inputDecorationTheme:
        inputDecorationTheme(t.elements.inputBase, base.inputDecorationTheme),
    textTheme: textTheme(base.textTheme, t),
    primaryTextTheme: textTheme(base.primaryTextTheme, t),
    accentTextTheme: textTheme(base.accentTextTheme, t),

    selectedRowColor: getColor(t.colors.selectedRow, base.selectedRowColor),
    highlightColor: getColor(t.colors.highlight, base.highlightColor),
    hintColor: getColor(t.colors.hint, base.hintColor),
    splashColor: getColor(t.colors.splash, base.splashColor),

    // TODO
    // chipTheme: ,
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
