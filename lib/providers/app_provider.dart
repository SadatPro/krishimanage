import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/land_model.dart';
import '../models/crop_model.dart';
import '../services/database_service.dart';
import '../services/weather_service.dart';
import '../services/notification_service.dart';

class AppProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final WeatherService _weatherService = WeatherService();
  final NotificationService _notificationService = NotificationService();

  User? _currentUser;
  List<Land> _lands = [];
  List<Crop> _activeCrops = [];
  Map<String, dynamic> _weatherData = {};
  Map<String, dynamic> _dashboardStats = {};
  bool _isLoading = false;
  String _error = '';

  // Getters
  User? get currentUser => _currentUser;
  List<Land> get lands => _lands;
  List<Crop> get activeCrops => _activeCrops;
  Map<String, dynamic> get weatherData => _weatherData;
  Map<String, dynamic> get dashboardStats => _dashboardStats;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Initialize app
  Future<void> initializeApp() async {
    _setLoading(true);
    try {
      await _notificationService.initialize();
      await _notificationService.scheduleDailyReminder();
      await _notificationService.scheduleWeeklyReport();
      _setError('');
    } catch (e) {
      _setError('অ্যাপ্লিকেশন শুরু করতে সমস্যা হয়েছে: $e');
    }
    _setLoading(false);
  }

  // User management
  Future<void> registerUser(User user) async {
    _setLoading(true);
    try {
      final userId = await _databaseService.insertUser(user);
      _currentUser = user.copyWith(id: userId);
      _setError('');
      notifyListeners();
    } catch (e) {
      _setError('নিবন্ধন করতে সমস্যা হয়েছে: $e');
    }
    _setLoading(false);
  }

  Future<void> loginUser(String email) async {
    _setLoading(true);
    try {
      final user = await _databaseService.getUserByEmail(email);
      if (user != null) {
        _currentUser = user;
        await loadUserData();
        _setError('');
      } else {
        _setError('ব্যবহারকারী পাওয়া যায়নি');
      }
    } catch (e) {
      _setError('লগইন করতে সমস্যা হয়েছে: $e');
    }
    _setLoading(false);
  }

  Future<void> loadUserData() async {
    if (_currentUser == null) return;

    _setLoading(true);
    try {
      // Load lands
      _lands = await _databaseService.getLandsByUserId(_currentUser!.id!);
      
      // Load active crops
      _activeCrops = await _databaseService.getActiveCropsByUserId(_currentUser!.id!);
      
      // Load dashboard stats
      _dashboardStats = await _databaseService.getDashboardStats(_currentUser!.id!);
      
      // Load weather data if location is available
      if (_lands.isNotEmpty && _lands.first.latitude != null && _lands.first.longitude != null) {
        await loadWeatherData(_lands.first.latitude!, _lands.first.longitude!);
      }
      
      _setError('');
    } catch (e) {
      _setError('ডেটা লোড করতে সমস্যা হয়েছে: $e');
    }
    _setLoading(false);
  }

  // Land management
  Future<void> addLand(Land land) async {
    _setLoading(true);
    try {
      final landId = await _databaseService.insertLand(land);
      final newLand = land.copyWith(id: landId);
      _lands.add(newLand);
      await loadUserData(); // Refresh stats
      _setError('');
      notifyListeners();
    } catch (e) {
      _setError('জমি যোগ করতে সমস্যা হয়েছে: $e');
    }
    _setLoading(false);
  }

  Future<void> updateLand(Land land) async {
    _setLoading(true);
    try {
      await _databaseService.updateLand(land);
      final index = _lands.indexWhere((l) => l.id == land.id);
      if (index != -1) {
        _lands[index] = land;
      }
      await loadUserData(); // Refresh stats
      _setError('');
      notifyListeners();
    } catch (e) {
      _setError('জমি আপডেট করতে সমস্যা হয়েছে: $e');
    }
    _setLoading(false);
  }

  // Crop management
  Future<void> addCrop(Crop crop) async {
    _setLoading(true);
    try {
      final cropId = await _databaseService.insertCrop(crop);
      final newCrop = crop.copyWith(id: cropId);
      _activeCrops.add(newCrop);
      await loadUserData(); // Refresh stats
      _setError('');
      notifyListeners();
    } catch (e) {
      _setError('ফসল যোগ করতে সমস্যা হয়েছে: $e');
    }
    _setLoading(false);
  }

  Future<void> updateCrop(Crop crop) async {
    _setLoading(true);
    try {
      await _databaseService.updateCrop(crop);
      final index = _activeCrops.indexWhere((c) => c.id == crop.id);
      if (index != -1) {
        _activeCrops[index] = crop;
      }
      await loadUserData(); // Refresh stats
      _setError('');
      notifyListeners();
    } catch (e) {
      _setError('ফসল আপডেট করতে সমস্যা হয়েছে: $e');
    }
    _setLoading(false);
  }

  // Weather management
  Future<void> loadWeatherData(double lat, double lon) async {
    try {
      _weatherData = await _weatherService.getCurrentWeather(lat, lon);
      notifyListeners();
    } catch (e) {
      _setError('আবহাওয়ার তথ্য লোড করতে সমস্যা হয়েছে: $e');
    }
  }

  Future<Map<String, dynamic>> getWeatherForecast(double lat, double lon) async {
    try {
      return await _weatherService.getWeatherForecast(lat, lon);
    } catch (e) {
      _setError('আবহাওয়ার পূর্বাভাস লোড করতে সমস্যা হয়েছে: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getWeatherAlerts(double lat, double lon) async {
    try {
      return await _weatherService.getWeatherAlerts(lat, lon);
    } catch (e) {
      _setError('আবহাওয়ার সতর্কতা লোড করতে সমস্যা হয়েছে: $e');
      return {};
    }
  }

  // Notifications
  Future<void> scheduleCropReminders() async {
    for (final crop in _activeCrops) {
      if (crop.expectedHarvestDate != null) {
        await _notificationService.showCropHarvestReminder(
          cropId: crop.id!,
          cropName: crop.name,
          harvestDate: crop.expectedHarvestDate!,
        );
      }
    }
  }

  Future<void> scheduleIrrigationReminders() async {
    for (final land in _lands) {
      if (land.status == 'active') {
        await _notificationService.showIrrigationReminder(
          landId: land.id!,
          landName: land.name,
        );
      }
    }
  }

  // Analytics
  Future<Map<String, dynamic>> getCropAnalytics() async {
    if (_currentUser == null) return {};

    try {
      final crops = await _databaseService.getActiveCropsByUserId(_currentUser!.id!);
      final totalArea = crops.fold(0.0, (sum, crop) => sum + crop.plantedArea);
      final totalExpectedYield = crops.fold(0.0, (sum, crop) => sum + (crop.expectedYield ?? 0));
      
      return {
        'totalCrops': crops.length,
        'totalArea': totalArea,
        'totalExpectedYield': totalExpectedYield,
        'averageProgress': crops.isEmpty ? 0 : crops.fold(0.0, (sum, crop) => sum + crop.progress) / crops.length,
      };
    } catch (e) {
      _setError('বিশ্লেষণ লোড করতে সমস্যা হয়েছে: $e');
      return {};
    }
  }

  // Utility methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _lands.clear();
    _activeCrops.clear();
    _weatherData.clear();
    _dashboardStats.clear();
    notifyListeners();
  }
}
