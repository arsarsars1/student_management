import 'package:flutter/material.dart';
import 'package:studet_managment/screens/batch_screen.dart';

import '../models/batch.dart';

class BatchCard extends StatelessWidget {
  final Batch batch;
  final bool isDetails;

  const BatchCard({super.key, required this.batch, this.isDetails = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            onTap: isDetails
                ? null
                : () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BatchScreen(batch: batch))),
            title: Text(batch.name),
            subtitle: Text('${batch.course} - ${batch.subject}'),
            trailing: Text(batch.status),
          ),
          if (isDetails)
            Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 12, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (batch.email.isNotEmpty) Text("Email ${batch.email}"),
                  Text("Admission Fees ${batch.admissionFee}"),
                  Text("Fees ${batch.fees}"),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
