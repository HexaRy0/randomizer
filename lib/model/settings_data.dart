class SettingsData {
  String? themeMode;
  bool? useMaterialYou;
  int? accentColor;

  SettingsData({
    this.themeMode,
    this.useMaterialYou,
    this.accentColor,
  });

  SettingsData.fromMap(Map<String, dynamic> map) {
    themeMode = map['themeMode'] as String?;
    useMaterialYou = map['useMaterialYou'] as bool?;
    accentColor = map['accentColor'] as int?;
  }

  Map<String, dynamic> toMap() {
    return {
      'themeMode': themeMode,
      'useMaterialYou': useMaterialYou,
      'accentColor': accentColor,
    };
  }
}
