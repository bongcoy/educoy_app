import 'package:educoy_app/core/res/colours.dart';
import 'package:educoy_app/core/res/fonts.dart';
import 'package:educoy_app/core/services/injection_container.dart';
import 'package:educoy_app/core/services/router.dart';
import 'package:educoy_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/common/manager/user_provider.dart';
import 'features/home/presentation/manager/home_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: MaterialApp(
        title: 'Educational App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.poppins,
          appBarTheme: const AppBarTheme(color: Colors.transparent),
        ),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
