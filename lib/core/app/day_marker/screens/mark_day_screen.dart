import 'package:drift/drift.dart' as df;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdaez/config/service_locator.dart';
import 'package:workdaez/core/app/day_marker/constants.dart';
import 'package:workdaez/core/app/profile/screens/add_profile_screen.dart';
import 'package:workdaez/core/app/profile/view_models/profile_list_provider.dart';
import 'package:workdaez/core/db/daos/tracker_dao.dart';
import 'package:workdaez/core/db/db_setup.dart';
import 'package:workdaez/core/services/secure_storage_service.dart';
import 'package:workdaez/shared/utils/constants.dart';
import 'package:workdaez/shared/utils/weekend_date_extensions.dart';

import '../providers/active_profile_provider.dart';
import '../providers/day_marked_provider.dart';

class MarkDayScreen extends HookConsumerWidget {
  const MarkDayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = useState(DateTime.now());
    final formatted = DateFormat('EEEE, MMMM d, y'); //.format(today.value);
    final activeProfile = ref.watch(activeProfileProvider);
    final size = MediaQuery.sizeOf(context);

    final profiles = ref.watch(profileListProvider).asData?.value ?? [];

    final daysToMark = today.value.day;

    final monthFormat = DateFormat('MMMM').format(today.value);

    return activeProfile.when(
      data: (profile) {
        final daysWorkedForMonth = ref.watch(daysWorkedForMonthProvider.call(profile?.id));

        return Banner(
          message: profile?.name ?? 'No Profile',
          location: BannerLocation.topEnd,
          child: Scaffold(
            extendBody: true,
            // extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: const Text('Mark Day'),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                // daysWorkedForMonth.when(
                //   data: (daysWorked) {
                //     return Text(daysWorked.toString());
                //   },
                //   skipError: true,
                //   loading: () => const SizedBox(),
                //   error: (_, __) => const SizedBox(),
                // ),
                PopupMenuButton<WorkProfileData>(
                  itemBuilder: (context) => profiles
                      .map(
                        (e) => PopupMenuItem(
                          value: e,
                          child: Text(e.name),
                        ),
                      )
                      .toList(),
                  initialValue: profile,
                  onSelected: (WorkProfileData profile) async {
                    await sl.get<SecureStorageService>().write(kActiveProfileKey, profile.id.toString());

                    await sl.get<SecureStorageService>().read(kActiveProfileKey);

                    ref.invalidate(activeProfileProvider);
                  },
                  child: const Icon(Icons.more_vert),
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  runSpacing: 8,
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: 8,
                  children: [
                    daysWorkedForMonth.when(
                      data: (daysWorked) {
                        return Container(
                          width: 200,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent, width: 2),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF335C81), Color(0xFFFFFFFF)],
                              begin: Alignment.topLeft,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Worked',
                                textAlign: TextAlign.start,
                              ),
                              Text('${daysWorked.toString()} day(s)'),
                              Text(
                                'For $monthFormat',
                                textAlign: TextAlign.end,
                              )
                            ],
                          ),
                        );
                      },
                      skipError: true,
                      loading: () => const SizedBox(),
                      error: (_, __) => const SizedBox(),
                    ),
                    ...AbsentValues.values.map((e) {
                      final offDays = ref.watch(offDaysByTypeProvider.call(e.name));
                
                      return offDays.when(
                        data: (daysOffForType) {
                          return Container(
                            width: 200,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text('Off'),
                                Text('${daysOffForType.toString()} day(s)'),
                                Text('For ${e.name} in $monthFormat'),
                              ],
                            ),
                          );
                        },
                        error: (_, __) => const SizedBox(),
                        loading: () => const SizedBox(),
                      );
                    })
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (context, int index) {
                      final day = DateTime(today.value.year, today.value.month, today.value.day - index);
                      final dayMarked = ref.watch(dayMarkedProvider.call(day)).value ?? false;

                      if (dayMarked) {
                        return Center(
                          child: Text('${formatted.format(day)}\nDay has already been marked. Have a cookie'),
                        );
                      }

                      if (profile == null) return const SizedBox();

                      if (!profile.trackWeekends && !day.isWeekDay) {
                        return _WeekendWidget(
                          day: formatted.format(day),
                        );
                      } else {
                        return _WeekdayWidget(
                          size: size,
                          formatted: formatted.format(day),
                          profile: profile,
                          day: day,
                        );
                      }
                    },
                    itemCount: daysToMark,
                    reverse: true,
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const Dialog.fullscreen(
                    child: AddProfileScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add_box_outlined),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text('$error, $stackTrace'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _WeekendWidget extends StatelessWidget {
  const _WeekendWidget({super.key, required this.day});

  final String day;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'It\'s the weekend!. Take a break\n$day',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}

class _WeekdayWidget extends HookConsumerWidget {
  const _WeekdayWidget({
    super.key,
    required this.size,
    required this.formatted,
    required this.profile,
    required this.day,
  });

  final Size size;
  final String formatted;
  final WorkProfileData profile;
  final DateTime day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = useState(WorkTrackerCompanion(
      day: df.Value(day),
      profileId: df.Value(profile.id),
      dateGenerated: df.Value(DateTime.now()),
    ));
    final absentReason = useState<String?>(null);

    return Stack(
      children: [
        ListView(
          // mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AnswerButton(
              height: size.height * 0.5,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      scrollable: true,
                      content: Column(
                        children: [
                          if (profile.trackTime) ...{
                            TextField(
                              onChanged: (value) {
                                model.value = model.value.copyWith(
                                  hoursWorked: df.Value(int.parse(value)),
                                );
                              },
                              decoration: const InputDecoration(
                                labelText: 'Hours',
                                hintText: 'Enter hours worked',
                              ),
                            ),
                          },
                          const SizedBox(height: 16),
                          TextField(
                            onChanged: (value) {
                              model.value = model.value.copyWith(
                                notes: df.Value(value),
                              );
                            },
                            decoration: const InputDecoration(
                              labelText: 'Note',
                              hintText: 'Add note here',
                            ),
                            maxLines: 5,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            final tracker = model.value.copyWith(didWork: const df.Value(true));

                            await sl.get<WorkTrackerDao>().insertDayWorked(tracker);

                            ref.invalidate(dayMarkedProvider);
                            ref.invalidate(daysWorkedForMonthProvider);
                            ref.invalidate(offDaysByTypeProvider);

                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor: Colors.green.shade200,
              child: const Text('Yes'),
            ),
            _AnswerButton(
              height: size.height * 0.5,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      scrollable: true,
                      content: HookConsumer(
                        builder: (context, ref, child) {
                          final absentReasonInternal = useState<AbsentValues?>(null);

                          return Column(
                            children: [
                              DropdownButton<AbsentValues?>(
                                items: AbsentValues.values
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.name),
                                        ))
                                    .toList(),
                                value: absentReasonInternal.value,
                                onChanged: (val) {
                                  absentReasonInternal.value = val;
                                  absentReason.value = absentReasonInternal.value?.name;
                                },
                              ),
                              if (absentReason.value == 'CUSTOM') ...{
                                TextField(
                                  onChanged: (value) {
                                    absentReason.value = value;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Reason',
                                    hintText: 'Enter reason for absence',
                                  ),
                                ),
                              },
                            ],
                          );
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            final tracker = model.value.copyWith(
                              didWork: const df.Value(false),
                              absentReason:
                                  absentReason.value != null ? df.Value(absentReason.value) : const df.Value(null),
                            );

                            await sl.get<WorkTrackerDao>().insertDayWorked(tracker);

                            ref.invalidate(dayMarkedProvider);
                            ref.invalidate(daysWorkedForMonthProvider);
                            ref.invalidate(offDaysByTypeProvider);

                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor: Colors.red.shade200,
              child: const Text('No'),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              formatted,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Did you work today?',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    );
  }
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.height,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: child,
      ),
    );
  }
}
