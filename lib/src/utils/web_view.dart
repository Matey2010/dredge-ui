import 'dart:convert';

String generateHtmlPage({
  required String html,
  String? css,
  String? headScript,
  String? bodyScript,
}) {
  return '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
      ${headScript ?? ""}
      <style>* { margin: 0; padding: 0; }${css == null ? "" : css}</style>
    </head>
    <body style='"margin: 0px; padding: 0px;'>
      $html
      ${bodyScript ?? ""}
    </body>
  ''';
}

String generateUrlHtmlPage({
  required String html,
  String? css,
  String? headScript,
  String? bodyScript,
}) {
  return Uri.dataFromString(
    generateHtmlPage(
      html: html,
      css: css,
      headScript: headScript,
      bodyScript: bodyScript,
    ),
    mimeType: 'text/html',
    encoding: Encoding.getByName('utf-8'),
  ).toString();
}
