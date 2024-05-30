import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studet_managment/screens/add_contacts_screen.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_state.dart';
import 'blocs/batch/batch_bloc.dart';
import 'repositories/auth_repository.dart';
import 'repositories/batch_repository.dart';
import 'screens/add_batch_screen.dart';
import 'screens/batch_list_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'utils/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(getIt<AuthRepository>()),
        ),
        BlocProvider(
          create: (context) => BatchBloc(getIt<BatchRepository>()),
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter BLoC & Hive Example',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:
                state is AuthAuthenticated ? const HomeScreen() : LoginScreen(),
            routes: {
              '/home': (context) => const HomeScreen(),
              '/batches': (context) => const BatchListScreen(),
              '/add_batch': (context) => const AddBatchScreen(),
              '/contact_page': (context) => const ContactsPage(),
            },
          );
        },
      ),
    );
  }
}
