import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdaez/core/app/day_marker/providers/day_marked_provider.dart';

import '../providers/active_profile_provider.dart';

class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDay = useState(DateTime.now());

    final activeProfile = ref.watch(activeProfileProvider).value;


    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, int month) {
          if (month == 0) return const SizedBox.shrink();

          final daysWorkedForMonthAsyncValue = ref.watch(daysWorkedForMonthWithMonthOptionProvider.call((month: month, profile: activeProfile?.id ?? 0)));

          return daysWorkedForMonthAsyncValue.when(
            data: (data) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(DateFormat("MMMM").format(DateTime(currentDay.value.year, month))),
                    Text('$data days'),
                  ],
                ),
              );
            },
            error: (_, __) => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
          );
        },
        itemCount: currentDay.value.month + 1,
      ),
    );
  }
}
