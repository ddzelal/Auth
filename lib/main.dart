import 'package:flutter/material.dart';
import 'package:flutter_application_auth/config/app_routes.dart';
import 'package:flutter_application_auth/provider/auth.provider.dart';
import 'package:flutter_application_auth/provider/user.provider.dart';
import 'package:flutter_application_auth/styles/app_colors.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // String? username = await SharedPrefsUtils.loadUsername();
  // print('Loaded username: $username');

  // String initialRoute = username != null && username.isNotEmpty
  //     ? AppRoutes.main
  //     : AppRoutes.initialPage;

  runApp(
      // MultiProvider(
      //   providers: [
      //     // ChangeNotifierProvider(create: (context) => ExpenseProvider()),
      //   ],
      //   child: MyApp(initialRoute: AppRoutes.login),
      // ),
      MyApp(
    initialRoute: AppRoutes.login,
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Urbanist',
          scaffoldBackgroundColor: AppColors.backgroundApp,
          // brightness: Brightness.dark,
        ),
        initialRoute: initialRoute,
        routes: AppRoutes.pages,
      ),
    );
  }
}
