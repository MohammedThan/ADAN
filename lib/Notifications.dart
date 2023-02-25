// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:timezone/timezone.dart';
// import 'package:timezone/timezone.dart' as tz;

// class NotificationApi {
//   static final _notification = FlutterLocalNotificationsPlugin();

//   static Future _notificationDetails() async {
//     return NotificationDetails(
//         android: AndroidNotificationDetails(
//           "channelId",
//           "channelName",
//           "channelDescription",
//           importance: Importance.max,
//         ),
//         iOS: IOSNotificationDetails());
//   }

//   static void showScheduledNotificaton({
//     required DateTime scheduledDate,
//   }) async =>
//       _notification.zonedSchedule(
//           0,
//           "Pray time",
//           "please pray",
//           tz.TZDateTime.from(scheduledDate, tz.local),
//           await _notificationDetails(),
//           uiLocalNotificationDateInterpretation:
//               UILocalNotificationDateInterpretation.absoluteTime,
//           androidAllowWhileIdle: true);


//   static Future init({bool initScheduled=false}) async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await _notification.initialize(
//       InitializationSettings(
//         android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//         iOS: IOSInitializationSettings(),
//       ),
//       onSelectNotification: (payload) async {
//         print("payload: $payload");
//       },
//     );
//     if (initScheduled) {
//       showScheduledNotificaton(scheduledDate: DateTime.now().add(Duration(seconds: 5)));
//     }
//   }
// }
