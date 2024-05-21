// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import '../../../auth/data/firebase_auth_repository.dart' show authRepositoryProvider;
import '../../../jobs/domain/job.dart' show JobID;
import '../../data/entries_repository.dart' show entriesRepositoryProvider;
import '../../domain/entry.dart' show Entry, EntryID;

part 'entry_screen_controller.g.dart';

@riverpod
class EntryScreenController extends _$EntryScreenController {
  @override
  FutureOr<void> build() {
    // 반환 유형이 FutureOr<void>인 경우 이 값을 비워두어도 괜찮습니다.
  }

  Future<bool> submit({
    EntryID? entryId,
    required JobID jobId,
    required DateTime start,
    required DateTime end,
    required String comment,
  }) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError("User can't be null");
    }
    final repository = ref.read(entriesRepositoryProvider);
    state = const AsyncLoading();
    if (entryId == null) {
      state = await AsyncValue.guard(
        () => repository.addEntry(
          uid: currentUser.uid,
          jobId: jobId,
          start: start,
          end: end,
          comment: comment,
        ),
      );
    } else {
      final entry = Entry(
        id: entryId,
        jobId: jobId,
        start: start,
        end: end,
        comment: comment,
      );
      state = await AsyncValue.guard(
        () => repository.updateEntry(uid: currentUser.uid, entry: entry),
      );
    }
    return state.hasError == false;
  }
}
