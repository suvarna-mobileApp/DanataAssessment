
import 'package:assessment/theme.dart';
import 'package:flutter/material.dart';
import 'app/routes.dart';
import 'di/service_locator.dart';
import 'env/env.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(

        future: getItInit(Env.prod()),
        builder: (context, s) {
          print(s.connectionState.toString());
          return s.connectionState == ConnectionState.done
              ? MaterialApp(
            title: 'Shopping Mall',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(context),
            initialRoute: Routes.navigationPage,
            onGenerateRoute: RouteGenerator.builder,
          )
              : Container(
            color: Colors.white,
          );
        });
  }
}

/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way - Template',
      theme: AppTheme.lightTheme(context),
      initialRoute: InitScreen.routeName,
      routes: routes,
    );
  }
}*/

