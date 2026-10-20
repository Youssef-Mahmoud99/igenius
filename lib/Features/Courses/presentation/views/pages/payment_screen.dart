import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:igenius/core/constants/app_routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/utils/helpers/app_navigtion.dart';

enum PaymentStatus { success, failed, unknown }

class PaymentResult {
  final PaymentStatus status;
  final String? reason;

  const PaymentResult(this.status, [this.reason]);

  bool get isSuccess => status == PaymentStatus.success;
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
  bool _finished = false;

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
            onMessageReceived: (msg) {
              _log('JS_CHANNEL', msg.message);
              final m = msg.message.trim().toLowerCase();
              if (m == 'success') {
                _finish(const PaymentResult(PaymentStatus.success));
              } else if (m == 'failed' || m == 'failure') {
                _finish(const PaymentResult(PaymentStatus.failed));
              }
            },
          )
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                _log('PAGE_STARTED', url);
                _checkUrl(url);
              },
              onPageFinished: (url) {
                _log('PAGE_FINISHED', url);
                _checkUrl(url);
              },
              onProgress: (p) {
                if (mounted) setState(() => _progress = p);
              },
              onUrlChange: (change) {
                final u = change.url;
                _log('URL_CHANGE', '$u');
                if (u != null) _checkUrl(u);
              },
              onNavigationRequest: (request) {
                _log('NAV_REQUEST', request.url);
                // لو اللينك ده نهاية الدفع، امنع تحميله وقفل الصفحة
                return _checkUrl(request.url)
                    ? NavigationDecision.prevent
                    : NavigationDecision.navigate;
              },
              onHttpError:
                  (e) => _log(
                    'HTTP_ERROR',
                    'status=${e.response?.statusCode} | uri=${e.request?.uri}',
                  ),
              onWebResourceError:
                  (e) => _log(
                    'WEB_RESOURCE_ERROR',
                    'code=${e.errorCode} | desc=${e.description} | url=${e.url}',
                  ),
            ),
          )
          ..setOnConsoleMessage(
            (m) => _log('CONSOLE_${m.level.name}', m.message),
          )
          ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  /// بيفحص اللينك. لو هو نهاية الدفع بيقفل الصفحة ويرجّع true.
  bool _checkUrl(String url) {
    final result = evaluateUrl(url);
    if (result == null) return false;
    _finish(result);
    return true;
  }

  PaymentResult? evaluateUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    // 1) صفحة الـ return بتاعت الباك اند
    if (uri.path.contains(widget.returnPathContains)) {
      final q = uri.queryParameters;
      bool isTrue(String k) => q[k]?.toLowerCase() == 'true';

      if (isTrue('success') && !isTrue('pending') && !isTrue('error_occured')) {
        return const PaymentResult(PaymentStatus.success);
      }
      return PaymentResult(PaymentStatus.failed, _extractFailureReason(q));
    }

    // 2) الباك اند بيعمل redirect لـ /login بعد الدفع (اللي كنت ماسكه قبل كده)
    //    مش عارفين النتيجة من اللينك، فبنرجّع unknown والـ caller يسأل السيرفر
    if (uri.path == '/login' || uri.path.endsWith('/login')) {
      return const PaymentResult(PaymentStatus.unknown);
    }

    return null;
  }

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

  void _finish(PaymentResult result) {
    if (_finished) return;
    _finished = true;
    _log('FINISH', 'status=${result.status} reason=${result.reason}');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      GoRouter.of(context).pop<PaymentResult>(result);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _finish(const PaymentResult(PaymentStatus.unknown)),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_progress < 100)
              LinearProgressIndicator(value: _progress / 100, minHeight: 3),
          ],
        ),
      ),
    );
  }
}
