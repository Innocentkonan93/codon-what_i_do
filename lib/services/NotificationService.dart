// ignore_for_file: unused_local_variable, file_names

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future _notificatonDetails() async {
    const sound = 'mixkit_bell_notification_933.wav';
    // Check if the device can vibrate
    bool canVibrate = await Vibrate.canVibrate;

// Vibrate
// Vibration duration is a constant 500ms because
// it cannot be set to a specific duration on iOS.
    Vibrate.vibrate();

// Vibrate with pauses between each vibration
    final Iterable<Duration> pauses = [
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 1000),
      const Duration(milliseconds: 500),
    ];
// vibrate - sleep 0.5s - vibrate - sleep 1s - vibrate - sleep 0.5s - vibrate
    Vibrate.vibrateWithPauses(pauses);

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'zoknot_channel_id',
        'channel Name',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound(sound.split('.').first),
      ),
      // iOS: IOSNotificationDetails(),
      iOS: const IOSNotificationDetails(sound: sound),
    );
  }

  static Future init({bool initSchedule = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const setting = InitializationSettings(android: android, iOS: iOS);

    // When app close
    final details = await _notification.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotification.add(details.payload);
    }
    await _notification.initialize(setting,
        onSelectNotification: (String? payload) async {
      onNotification.add(payload);
    });

    if (initSchedule) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  // static void display(RemoteMessage message) async {
  //   try {
  //     final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //     await _notification.show(
  //       id,
  //       message.notification!.title,
  //       message.notification!.body,
  //       await _notificatonDetails(),
  //       payload: message.data.toString(),
  //     );
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }

  static Future showNotification({
    int? id,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notification.show(
      id!,
      title,
      body,
      await _notificatonDetails(),
      payload: payload,
    );
  }

  static Future showSchudleNotification({
    int? id,
    String? title,
    String? body,
    String? payload,
    required tz.TZDateTime schudelDate,
  }) async {
    await _notification.zonedSchedule(
      id!,
      title,
      body,
      schudelDate,
      // tz.TZDateTime.from(schudelDate, tz.local),
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      await _notificatonDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    // cancel(id);
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );
    return scheduleDate.isBefore(now)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }

  static tz.TZDateTime scheduleWeekly(Time time, {required List<int> days}) {
    tz.TZDateTime scheduleDate = _scheduleDaily(time);
    while (!days.contains(scheduleDate.weekday)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  static void cancel(int id) => _notification.cancel(id);
  static void cancalAll() => _notification.cancelAll();
}
