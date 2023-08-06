import 'package:flutter/material.dart';
import 'package:gymming_app/state/state_week.dart';
import 'package:gymming_app/user_timetable/timetable.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(nativeAppKey: '5103199f9fd8a213a6e369fd4e67ea2f');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => StateWeek(
                year: DateTime.now().year,
                month: DateTime.now().month,
                dayOfSunday: DateTime.now().weekday == 7
                    ? DateTime.now().day
                    : DateTime.now().day - DateTime.now().weekday))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const TimeTable(),
      ),
    );
  }
}
