import 'package:flutter/material.dart';
import 'package:gymming_app/state/state_date_time.dart';
import 'package:gymming_app/user_timetable/user_timetable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

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
            create: (context) =>
                StateDateTime(selectedDateTime: DateTime.now()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black, fontFamily: 'Pretendard'),
        home: const UserTimeTable(),
        // home: const TrainerTimeTable(),
      ),
    );
  }
}
