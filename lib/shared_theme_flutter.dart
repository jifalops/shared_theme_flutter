/// It is recommended you import this library using the `as` directive, e.g.
/// `import 'package:shared_theme_flutter/shared_theme_flutter' as themer;`
library shared_theme_flutter;

import 'package:flutter/material.dart';
import 'package:shared_theme/shared_theme.dart' as sh;
import 'package:shared_theme_flutter/src/util.dart';

export 'package:shared_theme/shared_theme.dart';
export 'package:shared_theme_flutter/src/util.dart';

/// Sets the default theme.
void setTheme(sh.Theme theme) => currentTheme = theme;
sh.Theme currentTheme;

ThemeData themeData(sh.Theme t,
    [TargetPlatform platform = TargetPlatform.android]) {
  final base = t.brightness == sh.Brightness.light
      ? ThemeData.light()
      : ThemeData.dark();
  return base.copyWith(
    platform: platform,
    primaryColor: getColor(t.colors.primary),
    primaryColorLight: getColor(t.colors.primaryLight),
    primaryColorDark: getColor(t.colors.primaryDark),
    accentColor: getColor(t.colors.secondary),
    indicatorColor: getColor(t.colors.secondary),
    backgroundColor: getColor(t.colors.background),
    scaffoldBackgroundColor: getColor(t.colors.background),
    cardColor: getColor(t.colors.surface),
    dialogBackgroundColor: getColor(t.colors.surface),
    dividerColor: getColor(t.colors.divider),
    errorColor: getColor(t.colors.error),
    textSelectionColor: getColor(t.colors.primaryLight),
    textSelectionHandleColor: getColor(t.colors.primaryDark),

    /// Default color for [RaisedButton]s
    buttonColor: color(t.elements.primaryButton.color),
    buttonTheme: buttonTheme(t, t.elements.primaryButton),
    inputDecorationTheme: inputDecorationTheme(t.elements.inputBase),
    textTheme: textTheme(base.textTheme, t),
    primaryTextTheme: textTheme(base.primaryTextTheme, t),
    accentTextTheme: textTheme(base.accentTextTheme, t),

    // TODO
    // chipTheme: ,
    // selectedRowColor: getColor(t.colors.divider),
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

/// Get a widget based on [currentTheme.elements.inputBase].
Widget inputWidget(Widget input) =>
    wrap(input, currentTheme.elements.inputBase.margin);
