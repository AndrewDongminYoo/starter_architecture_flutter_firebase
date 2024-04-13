// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import '../../../entries/data/entries_repository.dart';
import '../../../entries/domain/entry.dart';
import '../../domain/job.dart';
import 'entry_list_item.dart';
import 'job_entries_list_controller.dart';
import '../../../../routing/app_router.dart';
import '../../../../utils/async_value_ui.dart';

class JobEntriesList extends ConsumerWidget {
  const JobEntriesList({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      jobsEntriesListControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final jobEntriesQuery = ref.watch(jobEntriesQueryProvider(job.id));
    return FirestoreListView<Entry>(
      query: jobEntriesQuery,
      itemBuilder: (context, doc) {
        final entry = doc.data();
        return DismissibleEntryListItem(
          dismissibleKey: Key('entry-${entry.id}'),
          entry: entry,
          job: job,
          onDismissed: () => ref
              .read(jobsEntriesListControllerProvider.notifier)
              .deleteEntry(entry.id),
          onTap: () => context.goNamed(
            AppRoute.entry.name,
            pathParameters: {'id': job.id, 'eid': entry.id},
            extra: entry,
          ),
        );
      },
    );
  }
}
