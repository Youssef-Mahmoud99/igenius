import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:igenius/app.dart';
import 'package:igenius/core/constants/app_routes.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import '../../injection/service_locator.dart';

class ConnectivityService {
  ConnectivityService._();
  static final instance = ConnectivityService._();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isDialogShowing = false;

  void startMonitoring() {
    _subscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final navigatorKey = sl<GlobalKey<NavigatorState>>();
      final context = navigatorKey.currentContext;
      if (context == null) return;

      final hasConnection = results.any(
        (result) => result != ConnectivityResult.none,
      );

      if (!hasConnection) {
        _showNoInternetDialog(context);
      } else {
        _closeDialogAndNavigate(context);
      }
    });
  }

  void stopMonitoring() {
    _subscription?.cancel();
    _isDialogShowing = false;
  }

  void _closeDialogAndNavigate(BuildContext context) {
    if (_isDialogShowing) {
      _isDialogShowing = false;
      Navigator.of(context, rootNavigator: true).pop();

      Future.delayed(Duration(milliseconds: 300), () {
        if (context.mounted) {
          if (currentUser == null){
          AppNavaigation.goToLogin();

          }
          else{
            AppNavaigation.goToHome(isGuest: false);
          }
        }
      });
    }
  }

  void _showNoInternetDialog(BuildContext context) {
    if (_isDialogShowing) return;

    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (dialogContext) => WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Icon(Icons.wifi_off, color: Colors.red, size: 28),
                  SizedBox(width: 12),
                  Text('No Internet'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'الرجاء التحقق من اتصال الإنترنت',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text(
                    'Waiting for connection...',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
    ).then((_) {
      _isDialogShowing = false;
    });
  }
}
