import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_projects/utility/common_methods.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../common_widgets/common_widget.dart';

class PDFViewWithWebView extends StatefulWidget {
  final String kaizenId;
  const PDFViewWithWebView({Key? key, required this.kaizenId}) : super(key: key);

  @override
  State<PDFViewWithWebView> createState() => _PDFViewWithWebViewState();
}

class _PDFViewWithWebViewState extends State<PDFViewWithWebView> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(context: context,title: 'PDF View'),
      body: WebView(
        initialUrl: 'http://sidis.skapsindia.com/test/api/kaizen-pdf/${widget.kaizenId}/${getLoginData()!.userdata!.first.id.toString()}',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
