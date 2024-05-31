import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studet_managment/blocs/auth/auth_bloc.dart';
import 'package:studet_managment/blocs/auth/auth_event.dart';
import 'package:studet_managment/widgets/card_widget.dart';

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
        childAspectRatio: 1.5,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        children: [
          CardWidget(
            icon: Icons.person,
            title: "Students",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Still under development')),
              );
            },
          ),
          CardWidget(
            icon: Icons.school,
            title: "Batches",
            onTap: () {
              Navigator.pushNamed(context, '/batches');
            },
          ),
        ],
      ),
    );
  }
}
