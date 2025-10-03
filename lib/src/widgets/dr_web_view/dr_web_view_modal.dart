import 'package:dredge_ui/src/widgets/dr_modal_header.dart';
import 'package:dredge_ui/src/widgets/dr_web_view/dr_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DrWebViewModal extends StatelessWidget {
  final VoidCallback? onClose;
  final VoidCallback? onGoBack;
  final String? title;
  final TextStyle? headerTitleStyle;
  final double? headerHeight;
  final EdgeInsets? headerPadding;
  final BoxDecoration? headerDecoration;
  final BoxDecoration? decoration;
  final EdgeInsets? webViewPadding;
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

  const DrWebViewModal({
    super.key,
    this.onClose,
    this.onGoBack,
    this.title,
    this.headerTitleStyle,
    this.headerHeight,
    this.headerPadding,
    this.headerDecoration,
    this.decoration,
    this.webViewPadding,
    this.baseUrl,
    this.initialUrl,
    this.initialHtml,
    this.javaScriptEnabled = true,
    this.disableHorizontalScroll = false,
    this.disableVerticalScroll = false,
    this.onLoadStop,
    this.onLoadStart,
    this.onEnterFullscreen,
    this.onWebViewCreated,
    this.onCloseWindow,
    this.shouldOverrideUrlLoading,
    this.onPermissionRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white).copyWith(
        color: decoration?.color,
        image: decoration?.image,
        border: decoration?.border,
        borderRadius: decoration?.borderRadius,
        boxShadow: decoration?.boxShadow,
        gradient: decoration?.gradient,
        backgroundBlendMode: decoration?.backgroundBlendMode,
      ),
      child: Column(
        children: [
          DrModalHeader(
            onClose: onClose,
            onGoBack: onGoBack,
            title: title,
            titleStyle: headerTitleStyle,
            height: headerHeight,
            padding: headerPadding,
            decoration: headerDecoration,
          ),
          Expanded(
            child: Padding(
              padding: webViewPadding ?? EdgeInsets.zero,
              child: DrWebView(
                baseUrl: baseUrl,
                initialUrl: initialUrl,
                initialHtml: initialHtml,
                javaScriptEnabled: javaScriptEnabled,
                disableHorizontalScroll: disableHorizontalScroll,
                disableVerticalScroll: disableVerticalScroll,
                onLoadStop: onLoadStop,
                onLoadStart: onLoadStart,
                onEnterFullscreen: onEnterFullscreen,
                onWebViewCreated: onWebViewCreated,
                onCloseWindow: onCloseWindow,
                shouldOverrideUrlLoading: shouldOverrideUrlLoading,
                onPermissionRequest: onPermissionRequest,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
