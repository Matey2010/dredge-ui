import 'package:dredge_ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DrWebView extends StatelessWidget {
  final String? baseUrl;
  final String? initialUrl;
  final String? initialHtml;
  final bool javaScriptEnabled;
  final bool disableHorizontalScroll;
  final bool disableVerticalScroll;
  final void Function(InAppWebViewController, Uri?)? onLoadStop;
  final void Function(InAppWebViewController, Uri?)? onLoadStart;
  final void Function(InAppWebViewController)? onEnterFullscreen;
  final void Function(InAppWebViewController)? onWebViewCreated;
  final void Function(InAppWebViewController controller)? onCloseWindow;
  final Future<NavigationActionPolicy?> Function(
    InAppWebViewController,
    NavigationAction,
  )?
  shouldOverrideUrlLoading;
  final Future<PermissionResponse?> Function(
    InAppWebViewController,
    PermissionRequest,
  )?
  onPermissionRequest;

  const DrWebView({
    this.onCloseWindow,
    this.initialUrl,
    this.initialHtml,
    this.onLoadStop,
    this.onWebViewCreated,
    this.javaScriptEnabled = true,
    this.disableHorizontalScroll = false,
    this.disableVerticalScroll = false,
    this.shouldOverrideUrlLoading,
    this.onLoadStart,
    this.onEnterFullscreen,
    this.onPermissionRequest,
    this.baseUrl, // Parameter only for initialHtml, it is needed to render as web pages as if they are on the site, required for licenses and scripts that use domain checks
    super.key,
  }) : assert(
         (initialUrl == null && initialHtml != null) ||
             (initialUrl != null && initialHtml == null),
         'Either initialUrl or initialHtml must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      onCloseWindow: onCloseWindow,
      onCreateWindow: (controller, createWindowAction) async {
        return false;
      },
      initialUrlRequest: let(initialUrl, (url) {
        return URLRequest(url: WebUri(initialUrl!));
      }),
      initialData: let(initialHtml, (html) {
        return InAppWebViewInitialData(
          baseUrl: WebUri(baseUrl!),
          data: initialHtml!,
          historyUrl: WebUri(baseUrl!),
          mimeType: 'text/html',
          encoding: 'utf-8',
        );
      }),
      onWebViewCreated: (controller) {
        onWebViewCreated?.call(controller);
      },
      shouldOverrideUrlLoading: shouldOverrideUrlLoading,
      initialSettings: InAppWebViewSettings(
        transparentBackground: true,
        supportZoom: false,
        javaScriptEnabled: javaScriptEnabled,
        disableHorizontalScroll: true,
        disableVerticalScroll: false,
        allowFileAccess: true,
        allowContentAccess: true,
        mediaPlaybackRequiresUserGesture: true,
        useWideViewPort: false,
        verticalScrollBarEnabled: true,
        userAgent:
            'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
      ),
      onPermissionRequest: onPermissionRequest,
      onLoadStart: (controller, url) {
        print('InAppWebView load started: $url');
        onLoadStart?.call(controller, url);
      },
      onLoadStop: (controller, url) {
        print('InAppWebView load stopped: $url');
        onLoadStop?.call(controller, url);
      },
      onReceivedError: (controller, request, error) {
        print('InAppWebView received error: $error');
      },
      onEnterFullscreen: onEnterFullscreen,
    );
  }
}
