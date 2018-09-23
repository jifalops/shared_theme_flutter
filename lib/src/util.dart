import 'package:flutter/material.dart';
import 'package:shared_theme/shared_theme.dart' as sh;

Color color(sh.Color c, [Color fallback]) =>
    c == null ? (fallback ?? Colors.transparent) : Color(c.argb);
Color getColor(sh.ContrastingColors colors, [Color fallback]) =>
    color(colors.color, fallback);
Color getContrast(sh.ContrastingColors colors, [Color fallback]) =>
    color(colors.contrast, fallback);

ButtonThemeData buttonTheme(
        sh.Theme theme, sh.Element button, ButtonThemeData fallback) =>
    ButtonThemeData(
      height: button.size?.minHeight ?? fallback.height,
      minWidth: button.size?.minWidth ?? fallback.minWidth,
      padding: edgeInsets(button.padding, fallback.padding),
      shape: shapeBorder(button, fallback.shape),
      textTheme: buttonTextTheme(theme, button),
    );

ButtonTextTheme buttonTextTheme(sh.Theme theme, [sh.Element button]) {
  button ??= theme.elements.primaryButton;
  return (button.font?.color) == theme.colors.primary.color
      ? ButtonTextTheme.primary
      : button.font?.color == theme.colors.secondary.color
          ? ButtonTextTheme.accent
          : ButtonTextTheme.normal;
}

EdgeInsets edgeInsets(sh.BoxSpacing spacing, [EdgeInsets fallback]) =>
    spacing == null
        ? fallback
        : EdgeInsets.fromLTRB(
            spacing.left, spacing.top, spacing.right, spacing.bottom);

ShapeBorder shapeBorder(sh.Element el, [ShapeBorder fallback]) =>
    el.border == null
        ? fallback
        : el.border.hasRadius
            ? RoundedRectangleBorder(
                side: borderSide(el.border.bottom),
                borderRadius: borderRadius(el.border))
            : Border(
                top: borderSide(el.border.top),
                right: borderSide(el.border.right),
                bottom: borderSide(el.border.bottom),
                left: borderSide(el.border.left),
              );

BorderSide borderSide(sh.BorderSide side) => BorderSide(
    width: side.width,
    style: borderStyle(side.style),
    color: color(side.color));

BorderStyle borderStyle(sh.BorderStyle style) =>
    style == sh.BorderStyle.solid ? BorderStyle.solid : BorderStyle.none;

BorderRadius borderRadius(sh.Border border, [BorderRadius fallback]) =>
    border == null
        ? fallback
        : BorderRadius.only(
            topLeft: radius(border.topLeft),
            topRight: radius(border.topRight),
            bottomRight: radius(border.bottomRight),
            bottomLeft: radius(border.bottomLeft));

Radius radius(sh.BorderRadius radius) => Radius.elliptical(radius.x, radius.y);

InputDecorationTheme inputDecorationTheme(sh.Element input,
        [InputDecorationTheme fallback]) =>
    InputDecorationTheme(
      border: inputBorder(input.border, fallback.border),
      contentPadding: edgeInsets(input.padding, fallback.contentPadding),
      fillColor: color(input.color, fallback.fillColor),
      filled: input.color == null
          ? fallback.filled
          : input.color != sh.Colors.transparent,
    );

InputBorder inputBorder(sh.Border border, [InputBorder fallback]) =>
    border == null
        ? fallback
        : border.hasUniformSides
            ? OutlineInputBorder(
                borderSide: borderSide(border.bottom),
                borderRadius: borderRadius(border))
            : UnderlineInputBorder(
                borderSide: borderSide(border.bottom),
                borderRadius: borderRadius(border));

TextTheme textTheme(TextTheme base, sh.Theme t) => base.copyWith(
    display4: textStyle(t.fonts.display4, base.display4),
    display3: textStyle(t.fonts.display3, base.display3),
    display2: textStyle(t.fonts.display2, base.display2),
    display1: textStyle(t.fonts.display1, base.display1),
    headline: textStyle(t.fonts.headline, base.headline),
    title: textStyle(t.fonts.title, base.title),
    subhead: textStyle(t.fonts.subhead, base.subhead),
    body2: textStyle(t.fonts.body2, base.body2),
    body1: textStyle(t.fonts.body1, base.body1),
    button: textStyle(t.fonts.button, base.button),
    caption: textStyle(t.fonts.caption, base.caption));

TextStyle textStyle(sh.Font font, [TextStyle base]) {
  base ??= TextStyle();
  return base.copyWith(
      fontFamily: font.family ?? base.fontFamily,
      color: color(font.color, base.color),
      fontWeight: fontWeight(font.weight, base.fontWeight),
      fontStyle: fontStyle(font.style, base.fontStyle),
      decoration: textDecoration(font.decoration, base.decoration),
      decorationColor: color(font.decoration?.color, base.decorationColor),
      decorationStyle:
          textDecorationStyle(font.decoration?.style, base.decorationStyle),
      height: font.height ?? base.height,
      fontSize: font.size ?? base.fontSize,
      letterSpacing: font.letterSpacing ?? base.letterSpacing,
      wordSpacing: font.wordSpacing ?? base.wordSpacing);
}

TextDecoration textDecoration(sh.TextDecoration decoration,
        [TextDecoration fallback]) =>
    decoration == null
        ? fallback
        : TextDecoration.combine(
            decoration.lines.map((line) => textDecorationLine(line)).toList());

TextDecoration textDecorationLine(sh.TextDecorationLine line) {
  switch (line) {
    case sh.TextDecorationLine.underline:
      return TextDecoration.underline;
    case sh.TextDecorationLine.overline:
      return TextDecoration.overline;
    case sh.TextDecorationLine.lineThrough:
      return TextDecoration.lineThrough;
    default:
      return TextDecoration.none;
  }
}

TextDecorationStyle textDecorationStyle(sh.TextDecorationStyle style,
    [TextDecorationStyle fallback]) {
  if (style == null) return fallback;
  switch (style) {
    case sh.TextDecorationStyle.dashed:
      return TextDecorationStyle.dashed;
    case sh.TextDecorationStyle.dotted:
      return TextDecorationStyle.dotted;
    case sh.TextDecorationStyle.double:
      return TextDecorationStyle.double;
    case sh.TextDecorationStyle.wavy:
      return TextDecorationStyle.wavy;
    default:
      return TextDecorationStyle.solid;
  }
}

FontWeight fontWeight(int weight, [FontWeight fallback]) {
  if (weight == null) return fallback;
  if (weight < 200) return FontWeight.w100;
  if (weight < 300) return FontWeight.w200;
  if (weight < 400) return FontWeight.w300;
  if (weight < 500) return FontWeight.w400;
  if (weight < 600) return FontWeight.w500;
  if (weight < 700) return FontWeight.w600;
  if (weight < 800) return FontWeight.w700;
  if (weight < 900) return FontWeight.w800;
  return FontWeight.w900;
}

FontStyle fontStyle(sh.FontStyle style, [FontStyle fallback]) => style == null
    ? fallback
    : style == sh.FontStyle.italic ? FontStyle.italic : FontStyle.normal;

Widget buttonWidget(sh.Element button, void Function() onPressed,
    {String text, Widget child}) {
  final base = RaisedButton(onPressed: () {});
  child ??= button.font == null
      ? Text(text)
      : Text(text, style: textStyle(button.font));
  return wrap(
      RaisedButton(
        elevation: button.shadow?.elevation ?? base.elevation,
        onPressed: onPressed,
        child: child,
        color: color(button.color, base.color),
        padding: edgeInsets(button.padding, base.padding),
        shape: shapeBorder(button, base.shape),
      ),
      button.margin);
}

/// Wraps [child] in [Padding] if [margin] is non-zero.
Widget wrap(Widget child, sh.BoxSpacing margin) =>
    (margin == null || margin == sh.BoxSpacing.zero)
        ? child
        : Padding(padding: edgeInsets(margin), child: child);
