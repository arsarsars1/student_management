import 'package:hive/hive.dart';

import '../models/batch.dart';

class BatchRepository {
  final Box<Batch> batchBox;

  BatchRepository(this.batchBox);

  List<Batch> getBatches() {
    return batchBox.values.toList();
  }

  Future<void> addBatch(Batch batch) async {
    await batchBox.add(batch);
  }
}
