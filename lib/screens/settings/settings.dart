import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:randomizer/providers/async_settings_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = ref.watch(asyncSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: settingsProvider.when(
        data: (settings) => Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              Text(
                "Theme",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.light_mode),
                title: const Text("Theme Mode"),
                subtitle: Text(
                  settings.themeMode == "light"
                      ? "Light"
                      : settings.themeMode == "dark"
                          ? "Dark"
                          : "Follow System",
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Theme Mode"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.light_mode),
                              title: const Text("Light"),
                              onTap: () {
                                ref.read(asyncSettingsProvider.notifier).setThemeMode("light");
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.dark_mode),
                              title: const Text("Dark"),
                              onTap: () {
                                ref.read(asyncSettingsProvider.notifier).setThemeMode("dark");
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.settings),
                              title: const Text("Follow System"),
                              onTap: () {
                                ref.read(asyncSettingsProvider.notifier).setThemeMode("system");
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.color_lens),
                title: const Text("Material You"),
                subtitle:
                    const Text("Use the color from your wallpaper (Only support Android 12+)"),
                value: settings.useMaterialYou ?? true,
                onChanged: (value) {
                  ref.read(asyncSettingsProvider.notifier).setUseMaterialYou(value);
                },
              ),
              ListTile(
                enabled: !(settings.useMaterialYou ?? true),
                leading: const FaIcon(FontAwesomeIcons.eyeDropper),
                title: const Text("Accent Color"),
                subtitle: const Text("Change the color of the app"),
                trailing: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: settings.useMaterialYou ?? true
                        ? Theme.of(context).colorScheme.primary
                        : Color(settings.accentColor ?? 4289974408),
                    shape: BoxShape.circle,
                  ),
                ),
                onTap: () {
                  debugPrint(Theme.of(context).colorScheme.primary.value.toString());
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Accent Color"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const FaIcon(FontAwesomeIcons.eyeDropper),
                              title: const Text("Pick Color"),
                              onTap: () async {
                                final color = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Pick Color"),
                                      content: SingleChildScrollView(
                                        child: MaterialPicker(
                                          pickerColor: Theme.of(context).colorScheme.primary,
                                          onColorChanged: (color) {
                                            Navigator.pop(context, color);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );

                                if (color != null) {
                                  ref
                                      .read(asyncSettingsProvider.notifier)
                                      .setAccentColor(color.value);
                                }

                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const FaIcon(FontAwesomeIcons.palette),
                              title: const Text("Default"),
                              onTap: () {
                                ref
                                    .read(asyncSettingsProvider.notifier)
                                    .setAccentColor(Theme.of(context).colorScheme.primary.value);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
              Text(
                "If by default the app doesn't follow your wallpaper color even when you turn on Material You, that's mean your device doesn't support Material You yet.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
