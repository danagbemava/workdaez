import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workdaez/core/app/day_marker/screens/mark_day_screen.dart';

import 'day_marker/screens/history_screen.dart';

class BaseScreen extends HookConsumerWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);

    final screens = useState([const MarkDayScreen(), const HistoryScreen()]);

    return Scaffold(
      body: screens.value[currentIndex.value],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.check), label: 'Mark Day'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
        ],
        selectedIndex: currentIndex.value,
        onDestinationSelected: (int index) {
          if (currentIndex.value != index) {
            currentIndex.value = index;
          }
        },
      ),
    );
  }
}
