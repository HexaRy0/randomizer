import 'package:randomizer/model/settings_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'async_settings_provider.g.dart';

@riverpod
class AsyncSettings extends _$AsyncSettings {
  Future<SettingsData> _fetchSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final themeMode = prefs.getString("themeMode") ?? "system";
    final useMaterialYou = prefs.getBool("useMaterialYou") ?? true;
    final accentColor = prefs.getInt("accentColor") ?? 4289974408;

    return SettingsData(
      themeMode: themeMode,
      useMaterialYou: useMaterialYou,
      accentColor: accentColor,
    );
  }

  @override
  FutureOr<SettingsData> build() async {
    return await _fetchSettings();
  }

  Future<void> setThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("themeMode", themeMode);

    state = await AsyncValue.guard(() async {
      return await _fetchSettings();
    });
  }

  Future<void> setUseMaterialYou(bool useMaterialYou) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("useMaterialYou", useMaterialYou);

    state = await AsyncValue.guard(() async {
      return await _fetchSettings();
    });
  }

  Future<void> setAccentColor(int primaryColor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("accentColor", primaryColor);

    state = await AsyncValue.guard(() async {
      return await _fetchSettings();
    });
  }
}
