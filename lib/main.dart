import 'package:flutter/material.dart';
import 'package:gymming_app/components/state_date_time.dart';
import 'package:gymming_app/pages/common/splash_screen.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:gymming_app/services/push_notification/push_notification_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'state/info_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await initializeDateFormatting();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  KakaoSdk.init(nativeAppKey: '5103199f9fd8a213a6e369fd4e67ea2f');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PushNotificationService _notificationService =
      PushNotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                StateDateTime(selectedDateTime: DateUtil.getKorTimeNow())),
        ChangeNotifierProvider(create: (context) => InfoState())
      ],
      child: MaterialApp(
        navigatorKey: MyApp.navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black, fontFamily: 'Pretendard'),
        home: SplashScreen(),
      ),
    );
  }
}
