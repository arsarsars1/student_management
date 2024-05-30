import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studet_managment/blocs/batch/batch_bloc.dart';
import 'package:studet_managment/blocs/batch/batch_event.dart';
import 'package:studet_managment/blocs/batch/batch_state.dart';

import '../widgets/batch_card.dart';

class BatchListScreen extends StatefulWidget {
  const BatchListScreen({super.key});

  @override
  State<BatchListScreen> createState() => _BatchListScreenState();
}

class _BatchListScreenState extends State<BatchListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BatchBloc>().add(LoadBatchesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batches'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add_batch');
            },
          ),
        ],
      ),
      body: BlocBuilder<BatchBloc, BatchState>(
        builder: (context, state) {
          if (state is BatchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BatchLoaded) {
            if (state.batches.isEmpty) {
              return const Center(child: Text('No batches available.'));
            }
            return ListView.builder(
              itemCount: state.batches.length,
              itemBuilder: (context, index) {
                return BatchCard(batch: state.batches[index]);
              },
            );
          } else {
            return const Center(child: Text('Failed to load batches.'));
          }
        },
      ),
    );
  }
}
