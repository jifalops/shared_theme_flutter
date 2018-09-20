import 'package:flutter/material.dart';
import 'package:shared_theme/shared_theme.dart' as sh;

Color color(sh.Color c) => Color(c.argb);
Color getColor(sh.ContrastingColors colors) => Color(colors.color.argb);
Color getContrast(sh.ContrastingColors colors) => Color(colors.contrast.argb);

ButtonThemeData buttonTheme(sh.Theme theme, sh.Element button) =>
    ButtonThemeData(
      height: button.size.minHeight,
      minWidth: button.size.minWidth,
      padding: edgeInsets(button.padding),
      shape: shapeBorder(button),
      textTheme: buttonTextTheme(theme, button),
    );

ButtonTextTheme buttonTextTheme(sh.Theme theme, [sh.Element button]) {
  button ??= theme.elements.primaryButton;
  return button.font.color == theme.colors.primary.color
      ? ButtonTextTheme.primary
      : button.font.color == theme.colors.secondary.color
          ? ButtonTextTheme.accent
          : ButtonTextTheme.normal;
}

EdgeInsets edgeInsets(sh.BoxSpacing spacing) => EdgeInsets.fromLTRB(
    spacing.left, spacing.top, spacing.right, spacing.bottom);

ShapeBorder shapeBorder(sh.Element el) => el.border.hasRadius
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

BorderRadius borderRadius(sh.Border border) => BorderRadius.only(
    topLeft: radius(border.topLeft),
    topRight: radius(border.topRight),
    bottomRight: radius(border.bottomRight),
    bottomLeft: radius(border.bottomLeft));

Radius radius(sh.BorderRadius radius) => Radius.elliptical(radius.x, radius.y);

InputDecorationTheme inputDecorationTheme(sh.Element input) =>
    InputDecorationTheme(
      border: inputBorder(input.border),
      contentPadding: edgeInsets(input.padding),
      fillColor: color(input.color),
      filled: input.color != sh.Colors.transparent,
    );

InputBorder inputBorder(sh.Border border) => border.hasUniformSides
    ? OutlineInputBorder(
        borderSide: borderSide(border.bottom),
        borderRadius: borderRadius(border))
    : UnderlineInputBorder(
        borderSide: borderSide(border.bottom),
        borderRadius: borderRadius(border));

TextTheme textTheme(TextTheme base, sh.Theme t) => base.copyWith(
    display4: textStyle(base.display4, t.fonts.display4),
    display3: textStyle(base.display3, t.fonts.display3),
    display2: textStyle(base.display2, t.fonts.display2),
    display1: textStyle(base.display1, t.fonts.display1),
    headline: textStyle(base.headline, t.fonts.headline),
    title: textStyle(base.title, t.fonts.title),
    subhead: textStyle(base.subhead, t.fonts.subhead),
    body2: textStyle(base.body2, t.fonts.body2),
    body1: textStyle(base.body1, t.fonts.body1),
    button: textStyle(base.button, t.fonts.button),
    caption: textStyle(base.caption, t.fonts.caption));

TextStyle textStyle(TextStyle base, sh.Font font) => base.copyWith(
    fontFamily: font.family,
    color: color(font.color),
    fontWeight: fontWeight(font.weight),
    fontStyle: fontStyle(font.style),
    decoration: textDecoration(font.decoration),
    decorationColor: color(font.decoration.color),
    decorationStyle: textDecorationStyle(font.decoration.style),
    height: font.height,
    fontSize: font.size,
    letterSpacing: font.letterSpacing,
    wordSpacing: font.wordSpacing);

TextDecoration textDecoration(sh.TextDecoration decoration) =>
    TextDecoration.combine(
        decoration.lines.map((line) => textDecorationLine(line)));

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

TextDecorationStyle textDecorationStyle(sh.TextDecorationStyle style) {
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

FontWeight fontWeight(int weight) {
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

FontStyle fontStyle(sh.FontStyle style) =>
    style == sh.FontStyle.italic ? FontStyle.italic : FontStyle.normal;
