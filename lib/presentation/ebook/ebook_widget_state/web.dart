import 'dart:ui_web';

import 'package:beta/helper/js_helper.dart';
import 'package:beta/presentation/ebook/ebook_widget.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'dart:js_interop'; // For JavaScript interop

class EbookWidgetState extends State<EbookWidget> {
  String viewID = "webviewer-id";
  String url = '';

  @override
  void initState() {
    super.initState();

    // Create and configure the div element dynamically
    final element = createElement('div') as web.Element;
    element.setAttribute('id', 'canvas');

    // Create and append the script element dynamically
    final script = createElement('script') as web.Element;
    script.innerHTML = """
        const canvas = document.querySelector("flt-platform-view").shadowRoot.querySelector("#canvas");
        WebViewer({
          path: 'WebViewer/lib',
          initialDoc: '$url'
        }, canvas).then((instance) => {
            // call apis here
        });
        """
        .toJS;
    element.appendChild(script);

    // Register the div element as a platform view
    platformViewRegistry.registerViewFactory(viewID, (int viewId) => element);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDFTron Flutter Demo'),
        ),
        body: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: Container(
            alignment: Alignment.center,
            child: HtmlElementView(
              viewType: viewID,
            ),
          ),
        ));
  }
}
