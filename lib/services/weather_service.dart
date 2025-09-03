import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  static const String _apiKey = 'YOUR_OPENWEATHER_API_KEY'; // Replace with actual API key
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Map<String, dynamic>> getCurrentWeather(double lat, double lon) async {
    try {
      final response = await http.get(Uri.parse(
        '$_baseUrl/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=bn'
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'temperature': data['main']['temp'],
          'humidity': data['main']['humidity'],
          'pressure': data['main']['pressure'],
          'description': data['weather'][0]['description'],
          'icon': data['weather'][0]['icon'],
          'windSpeed': data['wind']['speed'],
          'visibility': data['visibility'],
        };
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      // Return mock data for development
      return {
        'temperature': 28.5,
        'humidity': 75,
        'pressure': 1013,
        'description': 'আংশিক মেঘলা',
        'icon': '02d',
        'windSpeed': 3.2,
        'visibility': 10000,
      };
    }
  }

  Future<Map<String, dynamic>> getWeatherForecast(double lat, double lon) async {
    try {
      final response = await http.get(Uri.parse(
        '$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=bn'
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Map<String, dynamic>> forecast = [];
        
        for (var item in data['list']) {
          forecast.add({
            'date': DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000),
            'temperature': item['main']['temp'],
            'humidity': item['main']['humidity'],
            'description': item['weather'][0]['description'],
            'icon': item['weather'][0]['icon'],
            'windSpeed': item['wind']['speed'],
          });
        }
        
        return {'forecast': forecast};
      } else {
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      // Return mock forecast data for development
      final List<Map<String, dynamic>> mockForecast = [];
      final now = DateTime.now();
      
      for (int i = 0; i < 5; i++) {
        mockForecast.add({
          'date': now.add(Duration(days: i)),
          'temperature': 25 + (i * 2),
          'humidity': 70 + (i * 5),
          'description': i % 2 == 0 ? 'সূর্যালোক' : 'মেঘলা',
          'icon': i % 2 == 0 ? '01d' : '03d',
          'windSpeed': 2.5 + (i * 0.5),
        });
      }
      
      return {'forecast': mockForecast};
    }
  }

  Future<Map<String, dynamic>> getWeatherAlerts(double lat, double lon) async {
    try {
      final response = await http.get(Uri.parse(
        '$_baseUrl/onecall?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=bn&exclude=current,minutely,hourly,daily'
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Map<String, dynamic>> alerts = [];
        
        if (data['alerts'] != null) {
          for (var alert in data['alerts']) {
            alerts.add({
              'event': alert['event'],
              'description': alert['description'],
              'start': DateTime.fromMillisecondsSinceEpoch(alert['start'] * 1000),
              'end': DateTime.fromMillisecondsSinceEpoch(alert['end'] * 1000),
            });
          }
        }
        
        return {'alerts': alerts};
      } else {
        throw Exception('Failed to load weather alerts');
      }
    } catch (e) {
      // Return mock alerts for development
      return {
        'alerts': [
          {
            'event': 'তীব্র বৃষ্টিপাত',
            'description': 'আগামী ২৪ ঘণ্টায় ভারী বৃষ্টিপাতের সম্ভাবনা',
            'start': DateTime.now(),
            'end': DateTime.now().add(Duration(days: 1)),
          }
        ]
      };
    }
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  String getWeatherAdvice(Map<String, dynamic> weather) {
    final temp = weather['temperature'];
    final humidity = weather['humidity'];
    final description = weather['description'];

    if (temp > 35) {
      return 'উচ্চ তাপমাত্রা। ফসলের জন্য অতিরিক্ত সেচ প্রয়োজন।';
    } else if (temp < 15) {
      return 'নিম্ন তাপমাত্রা। ফসলের সুরক্ষার ব্যবস্থা নিন।';
    } else if (humidity > 80) {
      return 'উচ্চ আর্দ্রতা। রোগ প্রতিরোধের জন্য সতর্কতা প্রয়োজন।';
    } else if (description.contains('বৃষ্টি')) {
      return 'বৃষ্টিপাত। সেচ বন্ধ রাখুন এবং নিকাশের ব্যবস্থা নিশ্চিত করুন।';
    } else {
      return 'আবহাওয়া অনুকূল। স্বাভাবিক কৃষি কার্যক্রম চালিয়ে যান।';
    }
  }
}
