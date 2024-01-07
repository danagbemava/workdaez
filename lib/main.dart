import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:workdaez/core/db/db_setup.dart';

import 'config/service_locator.dart';
import 'core/app/day_marker/screens/mark_day_screen.dart';

Future<void> main() async{
  try {
    WidgetsFlutterBinding.ensureInitialized();

    setupLocators();

    await insertDefaultProfile();

    runApp(const ProviderScope(child: MyApp()));
  } catch (e, trc) {
    runApp(ErrorApp(e, trc));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToast = BotToastInit();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      builder: (context, child) {
        final builder = ResponsiveBreakpoints.builder(
          child: child!,
          // maxWidth: 1200,
          // minWidth: 480,
          // defaultScale: true,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
          ],
        );

        child = botToast(context, builder);

        return child;
      },
      home: const MarkDayScreen(),
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp(this.error, this.trace, {super.key});

  final Object error;
  final StackTrace trace;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error',
      home: Scaffold(
        body: Center(
          child: Text(
            '$error\n\n$trace',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
