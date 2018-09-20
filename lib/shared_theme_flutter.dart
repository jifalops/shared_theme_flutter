/// It is recommended you import this library as 'shared', or as 'sh' if using
/// it heavily.
library shared_theme_flutter;

import 'package:flutter/material.dart';
import 'package:shared_theme/shared_theme.dart' as sh;
import 'package:shared_theme_flutter/src/util.dart';

export 'package:shared_theme/shared_theme.dart';
export 'package:shared_theme_flutter/src/util.dart';

ThemeData buildTheme(sh.Theme t) {
  final base = t.brightness == sh.Brightness.light
      ? ThemeData.light()
      : ThemeData.dark();
  return base.copyWith(
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

class PrimaryButton extends RaisedButton {
  PrimaryButton(BuildContext context, String text, void Function() onPressed,
      ref.Theme theme,
      {Color color, Color textColor})
      : super(
          elevation: 8.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.button.copyWith(
                  color: textColor ?? Color(theme.onPrimaryButtonColor.argb),
                  fontSize: 16.0),
            ),
          ),
          color: color ?? Color(theme.primaryButtonColor.argb),
          onPressed: onPressed,
        );
}

class SecondaryButton extends FlatButton {
  SecondaryButton(BuildContext context, String text, void Function() onPressed,
      ref.Theme theme)
      : super(
            color: Color(theme.secondaryButtonColor.argb),
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Color(theme.onSecondaryButtonColor.argb))),
            onPressed: onPressed);
}

class TertiaryButton extends FlatButton {
  TertiaryButton(String text, onPressed)
      : super(
            child: Text(text),
            onPressed: onPressed,
            padding: EdgeInsets.all(2.0));
}
