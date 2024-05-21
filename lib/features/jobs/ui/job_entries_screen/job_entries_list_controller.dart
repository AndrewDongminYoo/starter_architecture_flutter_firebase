// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 🌎 Project imports:
import '../../../auth/data/firebase_auth_repository.dart' show authRepositoryProvider;
import '../../../entries/data/entries_repository.dart' show entriesRepositoryProvider;
import '../../../entries/domain/entry.dart' show EntryID;

part 'job_entries_list_controller.g.dart';

@riverpod
class JobsEntriesListController extends _$JobsEntriesListController {
  @override
  FutureOr<void> build() {
    // 반환 타입이 FutureOr<void>인 경우 이 값을 비워두어도 괜찮습니다.
  }

  Future<void> deleteEntry(EntryID entryId) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError("User can't be null");
    }
    final repository = ref.read(entriesRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => repository.deleteEntry(uid: currentUser.uid, entryId: entryId),
    );
  }
}
