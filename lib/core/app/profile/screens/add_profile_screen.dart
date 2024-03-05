import 'package:drift/drift.dart' as df;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:workdaez/core/app/profile/view_models/add_profile_view_model.dart';
import 'package:workdaez/core/db/db_setup.dart';

import '../view_models/profile_list_provider.dart';

class AddProfileScreen extends HookConsumerWidget {
  const AddProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());
    final trackWeekends = useState(false);
    final trackTime = useState(false);
    const gap = SizedBox(height: 16);

    return Form(
      key: formKey.value,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Create New Profile'),
            gap,
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a profile name';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Profile Name',
                border: OutlineInputBorder(),
              ),
            ),
            gap,
            CheckboxListTile.adaptive(
              value: trackWeekends.value,
              onChanged: (val) {
                trackWeekends.value = val!;
              },
              title: const Text('Track Weekends?'),
            ),
            gap,
            CheckboxListTile.adaptive(
              value: trackTime.value,
              onChanged: (val) {
                trackTime.value = val!;
              },
              title: const Text('Track Hours?'),
            ),
            gap,
            FilledButton(
              onPressed: () async {
                if (!formKey.value.currentState!.validate()) {
                  return;
                }

                final profileData = WorkProfileCompanion(
                  name: df.Value(nameController.text),
                  trackTime: df.Value(trackTime.value),
                  trackWeekends: df.Value(trackWeekends.value),
                );

                await ref.read(addProfileViewModel).save(profileData, onSuccess: () {
                  ref.invalidate(profileListProvider);
                  Navigator.pop(context);
                });
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
