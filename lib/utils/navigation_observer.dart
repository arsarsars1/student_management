import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';

class AuthNavigationObserver extends NavigatorObserver {
  final BuildContext context;

  AuthNavigationObserver(this.context);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _handleAuthState();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _handleAuthState();
  }

  void _handleAuthState() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      if (ModalRoute.of(context)?.settings.name != '/home') {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else if (authState is AuthUnauthenticated) {
      if (ModalRoute.of(context)?.settings.name != '/') {
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }
}
