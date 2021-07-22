import 'package:flutter/material.dart';
import 'package:nsostock/screens/dashboard/dashboard_screen.dart';
import 'package:nsostock/screens/login/login_screen.dart';
import 'package:nsostock/screens/onboarding/onboarding_screen.dart';
import 'package:nsostock/screens/register/register_screen.dart';

// สร้างตัวแปรแบบ Map ไว้เก็บ URL และ Screen
Map<String, WidgetBuilder> routes = {
  "/onboarding":(BuildContext context) => OnboardingScreen(),
  "/login":(BuildContext context) => LoginScreen(),
  "/register":(BuildContext context) => RegisterScreen(),
  "/dashboard":(BuildContext context) => DashboardScreen(),
};