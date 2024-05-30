import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studet_managment/blocs/auth/auth_bloc.dart';
import 'package:studet_managment/blocs/auth/auth_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutEvent());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Card(
            child: Center(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Students'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Still under development')),
                  );
                },
              ),
            ),
          ),
          Card(
            child: Center(
              child: ListTile(
                leading: const Icon(Icons.school),
                title: const Text('Batches'),
                onTap: () {
                  Navigator.pushNamed(context, '/batches');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
