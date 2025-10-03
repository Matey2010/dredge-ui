import 'package:dredge_ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' hide WebView;

class DrFixedHeightWebView extends StatefulWidget {
  final String? initialUrl;
  final String? initialHtml;
  final Color? backgroundColor;
  final bool javaScriptEnabled;
  final bool disableHorizontalScroll;
  final bool disableVerticalScroll;
  final void Function(InAppWebViewController, Uri?, double?)? onLoadStop;
  final void Function(InAppWebViewController, Uri?)? onLoadStart;
  final Future<NavigationActionPolicy?> Function(
    InAppWebViewController,
    NavigationAction,
  )?
  shouldOverrideUrlLoading;
  final void Function(InAppWebViewController)? onWebViewCreated;

  const DrFixedHeightWebView({
    this.initialUrl,
    this.initialHtml,
    this.backgroundColor,
    this.onLoadStart,
    this.onLoadStop,
    this.onWebViewCreated,
    this.shouldOverrideUrlLoading,
    this.javaScriptEnabled = true,
    this.disableHorizontalScroll = true,
    this.disableVerticalScroll = false,
    super.key,
  });

  @override
  State<DrFixedHeightWebView> createState() => _DrFixedHeightWebViewState();
}

class _DrFixedHeightWebViewState extends State<DrFixedHeightWebView> {
  double height = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DrWebView(
        baseUrl: 'about:blank',
        initialUrl: widget.initialUrl,
        initialHtml: widget.initialHtml,
        disableHorizontalScroll: widget.disableHorizontalScroll,
        disableVerticalScroll: widget.disableVerticalScroll,
        javaScriptEnabled: widget.javaScriptEnabled,
        onWebViewCreated: widget.onWebViewCreated,
        onLoadStart: widget.onLoadStart,
        shouldOverrideUrlLoading: widget.shouldOverrideUrlLoading,
        onLoadStop: (controller, url) async {
          final newHeight = await controller.evaluateJavascript(
            source: "document.documentElement.scrollHeight;",
          );

          setState(() {
            height = double.parse(newHeight.toString());
          });

          if (widget.onLoadStop != null) {
            widget.onLoadStop!(
              controller,
              url,
              double.parse(newHeight.toString()),
            );
          }
        },
      ),
    );
  }
}
