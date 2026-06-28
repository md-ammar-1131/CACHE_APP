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
      theme: ThemeData(primarySwatch: Colors.teal),
      home: BlocProvider(
        create: (context) => CacheBloc(),
        child: const MainScreen(),
      ),
    );
  }
}