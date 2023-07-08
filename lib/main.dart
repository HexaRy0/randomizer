import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:randomizer/helper/routes.dart';
import 'package:randomizer/static/route_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getApplicationDocumentsDirectory();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) {
        return MaterialApp(
          title: 'Randomizer!',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: lightColorScheme ??
                ThemeData.light(
                  useMaterial3: true,
                ).colorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: darkColorScheme ??
                ThemeData.dark(
                  useMaterial3: true,
                ).colorScheme,
            useMaterial3: true,
          ),
          themeMode: ThemeMode.system,
          initialRoute: RouteName.home,
          routes: routes,
        );
      },
    );
  }
}
