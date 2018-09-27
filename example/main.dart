// For a complete working example, see https://github.com/jifalops/shared_theme/example
import 'package:flutter/material.dart';
// import 'package:sharedtheme_example/config.dart' show appName;
// import 'package:sharedtheme_example/themes.dart' show themeset;
import 'package:shared_theme_flutter/shared_theme_flutter.dart' as themer;
import 'package:shared_preferences/shared_preferences.dart';

const appName = 'Dummy Example';
final themeset = themer.ThemeSet(themes: []);

void main() => runApp(App());

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  themer.Theme theme;

  @override
  void initState() {
    super.initState();
    // Set a default theme synchronously. If you want to wait until the user's
    // preferred theme is read from SharedPreferences, you'll need to show some
    // UI to the user in the mean time, such as a spinner or a splash screen.
    _setTheme(themeset.themes.first);

    // Lookup the preferred theme.
    _readTheme();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appName,
        theme: themer.themeData(theme),
        home: Scaffold(
          appBar: AppBar(
              title: Text(appName,
                  style: themer.textStyle(theme.fonts.title).copyWith(
                      color: Color(theme.colors.primary.contrast.argb))),
              actions: <Widget>[_buildThemeSwitch()]),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(child: DemoItems()),
          ),
        ),
      );

  void _setTheme(themer.Theme t) {
    theme = t;
    themer.currentTheme = t;
  }

  Widget _buildThemeSwitch() =>
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Text(
          'Dark',
          style: themer.textStyleColored(
              theme.fonts.title, themer.contrastOf(theme.colors.primary)),
        ),
        Switch(
          value: theme.brightness == themer.Brightness.dark,
          onChanged: (enabled) => _toggleTheme(),
        )
      ]);

  void _readTheme() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final name = prefs.getString('theme');
      setState(() => _setTheme(themeset.getThemeByName(name)));
    } catch (noSavedTheme) {}
  }

  void _toggleTheme() async {
    setState(() => _setTheme(theme == themeset.themes.first
        ? themeset.themes.last
        : themeset.themes.first));
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme.name);
  }
}

class DemoItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = themer.currentTheme;
    void _showSnackBar() => Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("I'm a SnackBar.")));
    Widget _colorWidget(themer.ContrastingColors colors, String text) =>
        _buildColorWidget(context, colors, text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
        Text('Display4', style: Theme.of(context).textTheme.display4),
        Text('Display3', style: Theme.of(context).textTheme.display3),
        Text('Display2', style: Theme.of(context).textTheme.display2),
        Text('Display1', style: Theme.of(context).textTheme.display1),
        Text('Headline', style: Theme.of(context).textTheme.headline),
        Text('Title', style: Theme.of(context).textTheme.title),
        Text('Subhead', style: Theme.of(context).textTheme.subhead),
        Text('Body2', style: Theme.of(context).textTheme.body2),
        Text('Body1', style: Theme.of(context).textTheme.body1),
        Text('Button', style: Theme.of(context).textTheme.button),
        Text('Caption', style: Theme.of(context).textTheme.caption),
        _colorWidget(theme.colors.primary, 'Primary'),
        _colorWidget(theme.colors.primaryLight, 'Primary Light'),
        _colorWidget(theme.colors.primaryDark, 'Primary Dark'),
        _colorWidget(theme.colors.secondary, 'Secondary ("Accent")'),
        _colorWidget(theme.colors.secondaryLight, 'Secondary Light'),
        _colorWidget(theme.colors.secondaryDark, 'Secondary Dark'),
        _colorWidget(theme.colors.background, 'Background'),
        _colorWidget(theme.colors.background.invert(), 'Background (inverted)'),
        _colorWidget(theme.colors.card, 'Card'),
        _colorWidget(theme.colors.divider, 'Divider'),
        _colorWidget(theme.colors.error, 'Error'),
        _colorWidget(theme.colors.notice, 'Notice'),
        _colorWidget(theme.colors.indicator, 'Indicator'),
        _colorWidget(theme.colors.hint, 'Hint'),
        _colorWidget(theme.colors.selectedRow, 'SelectedRow'),
        SizedBox(height: 12.0),
        themer.primaryButton(_showSnackBar, text: 'Primary Button'),
        SizedBox(height: 12.0),
        themer.secondaryButton(_showSnackBar, text: 'Secondary Button'),
        themer.tertiaryButton(_showSnackBar, text: 'Tertiary Button'),
        themer.wrapInput(
            TextField(decoration: InputDecoration(labelText: 'Input'))),
      ],
    );
  }

  Widget _buildColorWidget(
          BuildContext context, themer.ContrastingColors colors, String text) =>
      Container(
          alignment: Alignment.center,
          height: 56.0,
          width: 256.0,
          color: themer.colorOf(colors, Theme.of(context).backgroundColor),
          child: Text(text,
              style: Theme.of(context).textTheme.body2.copyWith(
                  color: themer.contrastOf(
                      colors, Theme.of(context).textTheme.body2.color))));
}
