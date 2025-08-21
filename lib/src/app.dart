import 'package:flutter/material.dart';
import 'package:future_builder_task/src/features/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
      ),
      home: const MainScreen(),
    );
  }
}
