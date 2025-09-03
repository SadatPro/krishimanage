import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings = 
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings iosSettings = 
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'krishimanage_channel',
      'কৃষি ব্যবস্থাপনা',
      channelDescription: 'কৃষি সম্পর্কিত বিজ্ঞপ্তি',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(id, title, body, details, payload: payload);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'krishimanage_scheduled_channel',
      'কৃষি সময়সূচী',
      channelDescription: 'কৃষি কার্যক্রমের সময়সূচী',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future<void> scheduleRepeatingNotification({
    required int id,
    required String title,
    required String body,
    required RepeatInterval repeatInterval,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'krishimanage_repeating_channel',
      'কৃষি পুনরাবৃত্তি',
      channelDescription: 'নিয়মিত কৃষি বিজ্ঞপ্তি',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      details,
      payload: payload,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Specific notification methods for agriculture
  Future<void> showCropHarvestReminder({
    required int cropId,
    required String cropName,
    required DateTime harvestDate,
  }) async {
    final daysUntilHarvest = harvestDate.difference(DateTime.now()).inDays;
    
    if (daysUntilHarvest <= 7) {
      await showNotification(
        id: cropId,
        title: 'ফসল কাটার সময়',
        body: '$cropName ${daysUntilHarvest} দিন পর কাটার সময় হবে। প্রস্তুতি নিন।',
        payload: 'crop_harvest_$cropId',
      );
    }
  }

  Future<void> showIrrigationReminder({
    required int landId,
    required String landName,
  }) async {
    await showNotification(
      id: landId + 1000, // Offset to avoid conflicts
      title: 'সেচের সময়',
      body: '$landName এ সেচ দেওয়ার সময় হয়েছে।',
      payload: 'irrigation_$landId',
    );
  }

  Future<void> showWeatherAlert({
    required String alertType,
    required String description,
  }) async {
    await showNotification(
      id: DateTime.now().millisecondsSinceEpoch % 100000,
      title: 'আবহাওয়া সতর্কতা: $alertType',
      body: description,
      payload: 'weather_alert',
    );
  }

  Future<void> showFertilizerReminder({
    required int cropId,
    required String cropName,
    required String fertilizerType,
  }) async {
    await showNotification(
      id: cropId + 2000,
      title: 'সারের সময়',
      body: '$cropName এ $fertilizerType সার দেওয়ার সময় হয়েছে।',
      payload: 'fertilizer_$cropId',
    );
  }

  Future<void> showPestControlReminder({
    required int cropId,
    required String cropName,
  }) async {
    await showNotification(
      id: cropId + 3000,
      title: 'কীটনাশক প্রয়োগ',
      body: '$cropName এ কীটনাশক প্রয়োগের সময় হয়েছে।',
      payload: 'pest_control_$cropId',
    );
  }

  Future<void> scheduleDailyReminder() async {
    await scheduleRepeatingNotification(
      id: 999,
      title: 'দৈনিক কৃষি পর্যালোচনা',
      body: 'আজকের কৃষি কার্যক্রম পর্যালোচনা করুন।',
      repeatInterval: RepeatInterval.daily,
    );
  }

  Future<void> scheduleWeeklyReport() async {
    // Schedule for every Sunday at 9:00 AM
    final now = DateTime.now();
    final nextSunday = now.add(Duration(days: (7 - now.weekday) % 7));
    final scheduledDate = DateTime(nextSunday.year, nextSunday.month, nextSunday.day, 9, 0);

    await scheduleNotification(
      id: 888,
      title: 'সাপ্তাহিক কৃষি প্রতিবেদন',
      body: 'এই সপ্তাহের কৃষি কার্যক্রমের প্রতিবেদন তৈরি করুন।',
      scheduledDate: scheduledDate,
      payload: 'weekly_report',
    );
  }
}
