import 'package:rxdart/rxdart.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  NotificationService._internal();
  static final onClickNotification = BehaviorSubject<String>();

  ///Inicializar el controlador de notificaciones
  Future<void> init() async {
    //Remove this method to stop OneSignal Debugging
    await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize("fe0ec0a5-b5eb-44a9-aef7-268988048d4f");
    var externalId = "123456789"; // You will supply the external id to the OneSignal SDK
    await OneSignal.login(externalId);
    OneSignal.Notifications.addPermissionObserver((state) {
      print("ONESIGNAL -- Has permission " + state.toString());
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();
    });

    var permission = OneSignal.Notifications.permission;

    print("ONESIGNAL -- base permission: $permission");
    if (permission == false) {
      bool canRequest = await OneSignal.Notifications.canRequest();
      print("ONESIGNAL -- can request $canRequest");
    }

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    // await OneSignal.Notifications.requestPermission(true);
    await OneSignal.User.pushSubscription.optIn();

    OneSignal.Notifications.addClickListener((event) {
      print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
    });

    tz.initializeTimeZones();
  }
}
