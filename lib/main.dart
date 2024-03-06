import 'package:educoy_app/core/res/colours.dart';
import 'package:educoy_app/core/res/fonts.dart';
import 'package:educoy_app/core/services/injection_container.dart';
import 'package:educoy_app/core/services/router.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Educational App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: Fonts.poppins,
        appBarTheme: const AppBarTheme(color: Colors.transparent),
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
