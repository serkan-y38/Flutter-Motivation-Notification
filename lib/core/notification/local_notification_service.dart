import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    initializeTimeZones();
    setLocalLocation(getLocation("Europe/Istanbul"));

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(initializationSettings);
  }

  Future showTestNotification() async {
    return notificationsPlugin.show(
      20,
      "Test",
      "body",
      NotificationDetails(
        android: AndroidNotificationDetails(
          '20',
          'test_channel',
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> scheduleNotification(
    int id,
    String chanelId,
    String chanelName,
    String title,
    String body,
    int delay,
  ) async {
    TZDateTime now = TZDateTime.now(local);
    TZDateTime scheduledDate = now.add(Duration(seconds: delay));

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      NotificationDetails(
        iOS: DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          priority: Priority.high,
          chanelId,
          chanelName,
          channelDescription: 'notification',
          styleInformation: BigTextStyleInformation(
            body,
            htmlFormatBigText: true,
          ),
        ),
      ),
    );
  }
}
