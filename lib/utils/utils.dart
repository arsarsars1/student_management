import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Utilities {
  static Future<void> requestPermissionAndFetchContacts(BuildContext context,
      {required Function function}) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      function();
    } else {
      if (context.mounted) {
        _handleInvalidPermissions(permissionStatus, context);
      }
    }
  }

  static Future<PermissionStatus> _getContactPermission() async {
    final status = await Permission.contacts.status;
    if (status != PermissionStatus.granted &&
        status != PermissionStatus.permanentlyDenied) {
      final result = await Permission.contacts.request();
      return result;
    }
    return status;
  }

  static void _handleInvalidPermissions(
      PermissionStatus permissionStatus, BuildContext context) {
    if (permissionStatus == PermissionStatus.denied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permissions error'),
            content: const Text(
                'Please enable contacts access permission in system settings'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permissions permanently denied'),
            content: const Text(
                'Please enable contacts access permission in system settings'),
            actions: [
              TextButton(
                child: const Text('Settings'),
                onPressed: () {
                  openAppSettings();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
