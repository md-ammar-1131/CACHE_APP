import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cache_bloc.dart';
import 'ui/main_screen.dart';

void main() {
  runApp(const AdvancedCacheApp());
}

class AdvancedCacheApp extends StatelessWidget {
  const AdvancedCacheApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Cache Simulator',
      // Applied a beginner-friendly dark theme
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF12121A), // Dark grey background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E2C), // Slightly lighter grey for app bars
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent, // Keeps your buttons and accents blue
        ),
      ),
      home: BlocProvider(
        create: (context) => CacheBloc(),
        child: const MainScreen(),
      ),
    );
  }
}