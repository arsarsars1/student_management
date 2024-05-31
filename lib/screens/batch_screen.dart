import 'package:flutter/material.dart';
import 'package:studet_managment/models/batch.dart';
import 'package:studet_managment/widgets/batch_card.dart';

class BatchScreen extends StatelessWidget {
  final Batch batch;
  const BatchScreen({super.key, required this.batch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          batch.name.toUpperCase(),
          textAlign: TextAlign.start,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(children: [
            BatchCard(batch: batch, isDetails: true),
            Expanded(
              child: ListView.builder(
                  itemCount: batch.students.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: SizedBox(
                        width: 70,
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: const Icon(
                            Icons.person,
                            size: 34,
                          ),
                        ),
                      ),
                      title: Text(batch.students[index]),
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
