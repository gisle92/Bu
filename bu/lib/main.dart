import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bu/screens/dashboard_screen.dart';
import 'package:bu/screens/onboarding_screen.dart';
import 'package:bu/state/bu_app_state.dart';

void main() {
  runApp(const BuApp());
}

class BuApp extends StatelessWidget {
  const BuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BuAppState(),
      child: MaterialApp(
        title: 'Bu',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B4C9B)),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF5F7FA),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        home: const _Gatekeeper(),
      ),
    );
  }
}

class _Gatekeeper extends StatelessWidget {
  const _Gatekeeper();

  @override
  Widget build(BuildContext context) {
    return Consumer<BuAppState>(
      builder: (context, state, _) {
        if (state.isOnboarded) {
          return const DashboardScreen();
        }
        return const OnboardingScreen();
      },
    );
  }
}
