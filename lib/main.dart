import 'package:flutter/material.dart';
import 'package:gymming_app/components/state_date_time.dart';
import 'package:gymming_app/pages/login/login_select_type.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
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
                StateDateTime(selectedDateTime: DateUtil.getKorTimeNow()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black, fontFamily: 'Pretendard'),
        home: LoginSelectType(),
      ),
    );
  }
}
