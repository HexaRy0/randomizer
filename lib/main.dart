import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:randomizer/helper/routes.dart';
import 'package:randomizer/model/group_list.dart';
import 'package:randomizer/static/route_name.dart';
import 'package:randomizer/static/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  await Isar.open([GroupListSchema], directory: dir.path, name: "randomizer");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) {
          return MaterialApp(
            title: StaticStrings.appName,
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
      ),
    );
  }
}
