import 'package:flutter/material.dart';

import '../models/batch.dart';

class BatchCard extends StatelessWidget {
  final Batch batch;

  const BatchCard({super.key, required this.batch});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(batch.name),
        subtitle: Text('${batch.course} - ${batch.subject}'),
        trailing: Text(batch.status),
      ),
    );
  }
}
