import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:learn_flutter/router/routes.dart';
import 'package:learn_flutter/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      routes: routes,
      navigatorObservers: [
        TalkerRouteObserver(GetIt.I<Talker>()),
      ],
    );
  }
}
