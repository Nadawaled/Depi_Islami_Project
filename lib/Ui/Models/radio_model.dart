class RadioModel {
  static const int defaultRadioIndex = 13;
  static const String nameKey = "name";
  static const String urlKey = "url";
  static const String radiosKey = "radios";

  final String url;
  final String name;

  RadioModel({
    required this.url,
    required this.name,
  });

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    return RadioModel(
      name: _extractRadioName(json),
      url: _extractRadioUrl(json),
    );
  }

  static String _extractRadioName(Map<String, dynamic> json) {
    return json[radiosKey][defaultRadioIndex][nameKey] as String;
  }

  static String _extractRadioUrl(Map<String, dynamic> json) {
    return json[radiosKey][defaultRadioIndex][urlKey] as String;
  }

  Map<String, dynamic> toJson() {
    return {
      nameKey: name,
      urlKey: url,
    };
  }

  bool get hasValidUrl => url.isNotEmpty;

  bool get hasValidName => name.isNotEmpty;

  @override
  String toString() {
    return 'RadioModel(name: $name, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RadioModel && other.url == url && other.name == name;
  }

  @override
  int get hashCode => url.hashCode ^ name.hashCode;
}
