import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:randomizer/helper/routes.dart';
import 'package:randomizer/model/group_list.dart';
import 'package:randomizer/providers/async_settings_provider.dart';
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
    return const ProviderScope(
      child: MainApp(),
    );
  }
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(asyncSettingsProvider);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) {
        return settings.when(
          data: (settings) => MaterialApp(
            title: StaticStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: settings.useMaterialYou ?? true
                  ? lightColorScheme
                  : ColorScheme.fromSeed(
                      brightness: Brightness.light,
                      seedColor: Color(
                        settings.accentColor ?? 4289974408,
                      ),
                    ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: settings.useMaterialYou ?? true
                  ? darkColorScheme
                  : ColorScheme.fromSeed(
                      brightness: Brightness.dark,
                      seedColor: Color(
                        settings.accentColor ?? 4289974408,
                      ),
                    ),
              useMaterial3: true,
            ),
            themeMode: settings.themeMode == "light"
                ? ThemeMode.light
                : settings.themeMode == "dark"
                    ? ThemeMode.dark
                    : ThemeMode.system,
            initialRoute: RouteName.home,
            routes: routes,
          ),
          error: (error, stackTrace) => MaterialApp(
            title: StaticStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: lightColorScheme,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: darkColorScheme,
              useMaterial3: true,
            ),
            themeMode: ThemeMode.system,
            initialRoute: RouteName.home,
            routes: routes,
          ),
          loading: () => MaterialApp(
            title: StaticStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: lightColorScheme,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: darkColorScheme,
              useMaterial3: true,
            ),
            themeMode: ThemeMode.system,
            initialRoute: RouteName.home,
            routes: routes,
          ),
        );
      },
    );
  }
}
