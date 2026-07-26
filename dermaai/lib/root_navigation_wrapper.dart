
import 'package:flutter/material.dart';

class RootNavigationWrapper extends StatefulWidget {
  final Widget child;

  const RootNavigationWrapper({super.key, required this.child});

  @override
  State<RootNavigationWrapper> createState() => _RootNavigationWrapperState();
}

class _RootNavigationWrapperState extends State<RootNavigationWrapper> {
  int _currentIndex = 0;

  void _onNavigationTargetChange(BuildContext context, int relativeIndex) {
    setState(() => _currentIndex = relativeIndex);
    // Explicit low friction custom router mechanics handling inline navigation layout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => _onNavigationTargetChange(context, idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.analytics_outlined), selectedIcon: Icon(Icons.analytics), label: 'Analysis'),
          NavigationDestination(icon: Icon(Icons.history_outlined), selectedIcon: Icon(Icons.history), label: 'History Logs'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Configuration'),
        ],
      ),
    );
  }
}