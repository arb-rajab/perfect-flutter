/*import 'dart:ui_web';

import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/ebook_data.dart';
import 'package:beta/helper/failure_response.dart';
import 'package:beta/helper/js_helper.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/ebook/ebook_screen_controller.dart';
import 'package:beta/presentation/ebook/ebook_widget.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:web/web.dart' as web;
import 'dart:js_interop'; // For JavaScript interop

import 'dart:html' as html;
import 'dart:ui' as ui;

class EbookWidgetState extends State<EbookWidget> {
  String viewID = "webviewer-id";
  late html.DivElement _element;
  bool loading = false;
  String url = '';
  late String password;
  EbookScreenController ebookScreenController = Get.find();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkService( onPreConnect: () {
        setState(() {
          loading = true;
        });
      }, onPostConnect: () {
        setState(() {
          loading = false;
        });
      }, onConnectionSucceed: (body) {
        EbookData ebookData = EbookData.fromJson(body['ebook']);
        setState(() {
          url = ebookData.url!.toString();
          password = ebookScreenController
              .decryptEncryptionKey(ebookData.ebook.encryptionKey);
        });
        _element = html.DivElement()
          ..id = 'canvas'
          ..append(html.ScriptElement()
            ..text = """
        const canvas = document.querySelector("flt-platform-view").querySelector("#canvas");
        WebViewer({
          path: 'WebViewer/lib',
          // initialDoc: '$url'
        }, canvas).then((instance) => {
            instance.UI.loadDocument('$url',{
            password:'$password'
            })
            const LayoutMode = instance.UI.LayoutMode;
            instance.UI.setLayoutMode(LayoutMode.Single);
            instance.UI.disableFeatures([Feature.Copy,Feature.Download,Feature.Print]);
            console.log(instance.annotationPopup.getItems());
            
            // call apis here
        });
        """);

        // ignore: undefined_prefixed_name
        ui.platformViewRegistry
            .registerViewFactory(viewID, (int viewId) => _element);
      }, onConnectionFailed: () {
        showOkDialogue(context, content: StringConstant.noConnection.tr());
      }, onMessageReceived: (failureResponse) {
        showOkDialogue(context, content: failureResponse.content);
      }).get(
          url: ApiConstant.getEbook.replaceFirst(
              '(TERM_ID)',
              ebookScreenController.ebookScreenArgument.term.term.id
                  .toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: Text(ebookScreenController.ebookScreenArgument.term.term.name),
        ),
        body: loading
            ? const LoadingWidget()
            : FractionallySizedBox(
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
*/
