import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentResult {
  final bool success;
  final String? reason;

  const PaymentResult(this.success, [this.reason]);
}

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;
  final String returnPathContains;

  const PaymentWebViewScreen({
    super.key,
    required this.paymentUrl,
    this.returnPathContains = '/checkout/paymob/return',
  });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  int _progress = 0;
  bool _paymentHandled = false;

  void _log(String tag, String message) {
    debugPrint('[PaymentWebView][$tag] $message');
  }

  @override
  void initState() {
    super.initState();
    _log('INIT', 'url = ${widget.paymentUrl}');

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.white)
          ..addJavaScriptChannel(
            'PaymentChannel',
            onMessageReceived: (JavaScriptMessage msg) {
              _log('JS_CHANNEL', msg.message);
              final m = msg.message.trim().toLowerCase();
              if (m == 'success') {
                handleSuccess(msg.message);
              } else if (m == 'failed' || m == 'failure') {
                handleFailure(msg.message, null);
              }
            },
          )
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) => _log('PAGE_STARTED', url),
              onPageFinished: (url) => _log('PAGE_FINISHED', url),
              onProgress: (p) {
                _log('PROGRESS', '$p%');
                if (mounted) setState(() => _progress = p);
              },
              onUrlChange: (change) => _log('URL_CHANGE', '${change.url}'),
              onNavigationRequest: (request) {
                _log(
                  'NAV_REQUEST',
                  'url=${request.url} | isMainFrame=${request.isMainFrame}',
                );

                final result = evaluateUrl(request.url);
                if (result != null) {
                  if (result.success) {
                    handleSuccess(request.url);
                  } else {
                    handleFailure(request.url, result.reason);
                  }
                  return NavigationDecision.prevent; // يمنع التحميل لـ /login
                }
                return NavigationDecision.navigate;
              },
              onHttpError: (error) {
                _log(
                  'HTTP_ERROR',
                  'status=${error.response?.statusCode} | uri=${error.request?.uri}',
                );
              },
              onWebResourceError: (error) {
                _log(
                  'WEB_RESOURCE_ERROR',
                  'code=${error.errorCode} | type=${error.errorType} | '
                      'mainFrame=${error.isForMainFrame} | desc=${error.description} | url=${error.url}',
                );
              },
            ),
          );

    _controller.setOnConsoleMessage((JavaScriptConsoleMessage m) {
      _log('CONSOLE_${m.level.name}', m.message);
    });

    _controller.loadRequest(Uri.parse(widget.paymentUrl));
  }


  PaymentResult? evaluateUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (!uri.path.contains(widget.returnPathContains)) return null;

    final q = uri.queryParameters;
    final ok =
        q['success'] == 'true' &&
        q['pending'] != 'true' &&
        q['error_occured'] != 'true' &&
        q['txn_response_code'] == 'APPROVED';
    if (ok) return const PaymentResult(true);

    return PaymentResult(false, _extractFailureReason(q));
  }

  /// بيطلع سبب الفشل من الـ query parameters
  String _extractFailureReason(Map<String, String> q) {
    if (q['pending'] == 'true') {
      return 'Your payment is still pending. Please check again later.';
    }
    final message = (q['data.message'] ?? '').trim();
    if (message.isNotEmpty && message.toLowerCase() != 'approved') {
      return message;
    }
    final code = (q['txn_response_code'] ?? '').trim();
    if (code.isNotEmpty && code != 'APPROVED') {
      return 'Transaction was not approved ($code).';
    }
    if (q['error_occured'] == 'true') {
      return 'An error occurred while processing your payment.';
    }
    return 'The payment could not be completed.';
  }


  void handleSuccess(String? url) {
    if (_paymentHandled) return;
    _paymentHandled = true;
    _log('PAYMENT_SUCCESS', 'url=$url');
    _finish(true);
  }

  void handleFailure(String? url, String? reason) {
    if (_paymentHandled) return;
    _paymentHandled = true;
    _log('PAYMENT_FAILED', 'reason=$reason | url=$url');
    _finish(false);
  }

  /// يقفل الصفحة ويرجّع النتيجة للي نادى عليها
  void _finish(bool success) {
    if (!mounted) return;
    context.pop<bool>(success);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) _log('CLOSED', 'payment page closed | result=$result');
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (_progress < 100)
                LinearProgressIndicator(value: _progress / 100, minHeight: 3),
            ],
          ),
        ),
      ),
    );
  }
}