import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdaez/core/app/profile/screens/add_profile_screen.dart';
import 'package:workdaez/shared/utils/weekend_date_extensions.dart';

import '../providers/active_profile_provider.dart';

class MarkDayScreen extends HookConsumerWidget {
  const MarkDayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = useState(DateTime.now());
    final formatted = DateFormat('EEEE, MMMM d, y').format(today.value);
    final activeProfile = ref.watch(activeProfileProvider).asData?.value;
    final size = MediaQuery.sizeOf(context);

    return Banner(
      message: activeProfile?.name ?? 'No Profile',
      location: BannerLocation.topEnd,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Mark Day'),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [          ],
        ),
        body:  _WeekdayWidget(size: size, formatted: formatted),// : _WeekendWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (context) => const Dialog.fullscreen(child: AddProfileScreen()));
          },
          child: const Icon(Icons.add_box_outlined),
        )
      ),
    );
  }
}

class _WeekendWidget extends StatelessWidget {
  const _WeekendWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'It\'s the weekend!. Take a break',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}

class _WeekdayWidget extends StatelessWidget {
  const _WeekdayWidget({
    super.key,
    required this.size,
    required this.formatted,
  });

  final Size size;
  final String formatted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          // mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AnswerButton(
              height: size.height * 0.5,
              onPressed: () {},
              backgroundColor: Colors.green.shade200,
              child: const Text('Yes'),
            ),
            _AnswerButton(
              height: size.height * 0.5,
              onPressed: () {},
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
          )
        ),
        child: child,
      ),
    );
  }
}
