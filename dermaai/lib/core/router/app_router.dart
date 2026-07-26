import 'package:dermaai/features/analysis/screens/home_screen.dart';
import 'package:dermaai/features/analysis/screens/loading_screen.dart';
import 'package:dermaai/features/analysis/screens/result_screen.dart';
import 'package:dermaai/features/analysis/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/analysis/screens/image_preview_screen.dart' show ImagePreviewScreen;
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

class AppRouter {
  static final GoRouter routerConfig = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/preview', builder: (context, state) => const ImagePreviewScreen()),
      GoRoute(path: '/loading', builder: (context, state) => const LoadingScreen()),
      GoRoute(path: '/result', builder: (context, state) => const ResultScreen()),
      GoRoute(path: '/history', builder: (context, state) => const HistoryScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
    ],
  );
}