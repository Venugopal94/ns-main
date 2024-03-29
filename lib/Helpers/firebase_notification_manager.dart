import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationManager {
  static FirebaseNotificationManager? instance = FirebaseNotificationManager._();
  String myToken = "";

  FirebaseNotificationManager._() {
    initialiseFirebase();
  }

  factory FirebaseNotificationManager() {
    instance ??= FirebaseNotificationManager._();
    // since you are sure you will return non-null value, add '!' operator
    return instance!;
  }

  Future<void> initialiseFirebase() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.requestPermission();

    final fcmToken = await FirebaseMessaging.instance.getToken();
    myToken = fcmToken ?? "";
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      myToken = newToken;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleTap(message);
    });
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleTap(message);
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      //handleTap(message);
    });
  }

  Future<void> handleTap(RemoteMessage message) async {

  }
  // void subscribe(String groupName) {
  //   FirebaseMessaging.instance.subscribeToTopic(groupName);
  // }

  // Future<void> sendPushNotifications(String fcmToken, String message, String title, String chatId, {bool isGroupChat = false , String groupName = "", String decoderName = ""}) async {
  //   try {
  //     var formData = json.encode(
  //         {
  //           "to" : isGroupChat ? ("/topics/$chatId") : fcmToken,
  //           "notification" : {
  //             "body" : message,
  //             "title": title,
  //             "routeType": isGroupChat ? "group_chat" : "single_chat"
  //           },
  //           "data": {
  //             "click_action": isGroupChat ? "group_chat" : "single_chat",
  //             "id": chatId,
  //             "status": "done",
  //             "decoderId" : fcmToken,
  //             "decoderName" : decoderName,
  //             "panelName" : groupName,
  //           },
  //         });
  //
  //     final dio = Dio(BaseOptions(
  //       connectTimeout: 30000,
  //       baseUrl: "https://fcm.googleapis.com/fcm",
  //       responseType: ResponseType.json,
  //       contentType: ContentType.json.toString(),
  //     ));
  //     dio.options.contentType = "application/json";
  //     var response = await dio.post(
  //       "/send",
  //       options: Options(headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //         "Authorization": "key=AAAAGSlFMB4:APA91bH9h-UfFzHUQvu6XaD-DGkMAyKJvAMgNTurydkaFEIYYmMYkPY2D4Ds1nwPHpkjwBRfeiIVFdG-GmSatMj_tK7inu24-EH7_KDMJg6NOpw_AmJfEfP_LKAATG1HIoinNDkcwTFc",
  //       }),
  //       data: formData,
  //     );
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> sendPushNotificationsToGroup(String groupName, String message, String title, String chatType) async {
  //
  //   try {
  //     var formData = json.encode(
  //         {
  //           "to" : "/topics/$groupName",
  //           "notification" : {
  //             "body" : "Body of Your Notification",
  //             "title": "Title of Your Notification"
  //           },
  //           "routeType": "single_chat"
  //         });
  //
  //     final dio = Dio(BaseOptions(
  //       connectTimeout: 30000,
  //       baseUrl: "https://fcm.googleapis.com/fcm",
  //       responseType: ResponseType.json,
  //       contentType: ContentType.json.toString(),
  //     ));
  //     dio.options.contentType = "application/json";
  //     var response = await dio.post(
  //       "/send",
  //       options: Options(headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //         "Authorization": "key=AAAAGSlFMB4:APA91bH9h-UfFzHUQvu6XaD-DGkMAyKJvAMgNTurydkaFEIYYmMYkPY2D4Ds1nwPHpkjwBRfeiIVFdG-GmSatMj_tK7inu24-EH7_KDMJg6NOpw_AmJfEfP_LKAATG1HIoinNDkcwTFc",
  //       }),
  //       data: formData,
  //     );
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> updateFCMToServer(String fcmToken) async {
  //   UserLoginCredentialsDatasource sharedPreference = getIt<UserLoginCredentialsDatasource>();
  //   ApiClient client = ApiClient(dio: Dio(), networkInfo: NetworkInfo(Connectivity()), credentialsDatasource: UserLoginCredentialsDatasource(await SharedPreferences.getInstance()));
  //   var response = await client.post("https://dreamsdecoding.org/api/fcm_token", request: UpdateFCMUsecaseParams(fcmToken: fcmToken), options: Options(headers: {
  //     HttpHeaders.contentTypeHeader: "application/json",
  //     "Authorization": "Bearer ${sharedPreference.getLoggedInCredentials()?.accessToken ?? ""}",
  //   }));
  //   print(response);
  // }
}

// class UpdateFCMUsecaseParams extends RequestParam {
//   final String fcmToken;
//   UpdateFCMUsecaseParams({
//     required this.fcmToken,
//   }) : super();
//
//   @override
//   Map<String, dynamic> toJson() {
//     return {
//       "fcmtoken": fcmToken,
//     };
//   }
// }