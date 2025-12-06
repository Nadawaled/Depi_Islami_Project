import 'package:islamy_app/Ui/Models/radio_model.dart';
import 'package:islamy_app/core/helper/api_services.dart';

class RadioServices {
  static const String radioApiUrl = "https://data-rosy.vercel.app/radio.json";
  static const String errorMessagePrefix = "Failed to fetch radio data";

  final ApiServices _apiServices;

  RadioServices({ApiServices? apiServices})
      : _apiServices = apiServices ?? ApiServices();

  Future<RadioModel> getRadio() async {
    try {
      final Map<String, dynamic> jsonData = await _fetchRadioJson();
      return _parseRadioModel(jsonData);
    } catch (error) {
      throw Exception('$errorMessagePrefix: $error');
    }
  }

  Future<Map<String, dynamic>> _fetchRadioJson() async {
    return await _apiServices.getMethod(apiUrl: radioApiUrl);
  }

  RadioModel _parseRadioModel(Map<String, dynamic> json) {
    return RadioModel.fromJson(json);
  }

  Future<bool> isRadioAvailable() async {
    try {
      final RadioModel radio = await getRadio();
      return radio.hasValidUrl;
    } catch (error) {
      return false;
    }
  }
}
