import "dart:convert";
import 'package:http/http.dart' as http;
import 'package:hands_on_app/weather_response_model.dart';

class WeatherService {
  Future<Weather> fetchTomorrowWeather(String locationCode) async {
    final response = await http.get(Uri.parse(
        'https://weather.tsukumijima.net/api/forecast?city=$locationCode'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      // return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
