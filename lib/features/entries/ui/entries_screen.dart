// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import '../../../constants/app_sizes.dart';
import '../../../constants/strings.dart';
import '../../../widgets/list_items_builder.dart';
import '../domain/entries_list_tile_model.dart';
import '../services/entries_service.dart';

class EntriesScreen extends ConsumerWidget {
  const EntriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.entries)),
      body: Consumer(
        builder: (context, ref, child) {
          // * 이 데이터는 두 개의 스트림에서 결합된 것이므로 리포지토리에서 쿼리 개체로 직접 반환할 수 없습니다.
          // * 따라서 여기서는 FirestoreListView를 사용할 수 없습니다.
          final entriesTileModelStream =
              ref.watch(entriesTileModelStreamProvider);
          return ListItemsBuilder<EntriesListTileModel>(
            data: entriesTileModelStream,
            itemBuilder: (context, model) => EntriesListTile(model: model),
          );
        },
      ),
    );
  }
}

class EntriesListTile extends StatelessWidget {
  const EntriesListTile({super.key, required this.model});

  final EntriesListTileModel model;

  @override
  Widget build(BuildContext context) {
    const fontSize = 16.0;
    return Container(
      color: model.isHeader ? Colors.indigo[100] : null,
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.p8,
        horizontal: Sizes.p16,
      ),
      child: Row(
        children: <Widget>[
          Text(model.leadingText, style: const TextStyle(fontSize: fontSize)),
          Expanded(child: Container()),
          if (model.middleText != null)
            Text(
              model.middleText!,
              style: TextStyle(color: Colors.green[700], fontSize: fontSize),
              textAlign: TextAlign.right,
            ),
          SizedBox(
            width: 60,
            child: Text(
              model.trailingText,
              style: const TextStyle(fontSize: fontSize),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
