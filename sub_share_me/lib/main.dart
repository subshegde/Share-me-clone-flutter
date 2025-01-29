import 'package:flutter/material.dart';
import 'package:sub_share_me/constants/app_colors.dart';
import 'package:sub_share_me/pages/global/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.bg,
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.black),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}
