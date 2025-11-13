import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/ebook_data.dart';
import 'package:beta/helper/encryption.dart';
import 'package:beta/presentation/dialogues/ok_dialogue.dart';
import 'package:beta/presentation/ebook/ebook_screen_controller.dart';
import 'package:beta/presentation/ebook/ebook_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class EbookWidgetState extends State<EbookWidget> {
  bool loading = true;
  String url = '';
  String password = '';

  @override
  void initState() {
    EbookScreenController ebookScreenController = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NetworkService(onPreConnect: () {
        setState(() => loading = true);
      }, onPostConnect: () {
        setState(() => loading = false);
      }, onConnectionSucceed: (body) {
        EbookData ebookData = EbookData.fromJson(body['ebook']);
        setState(() {
          url = ebookData.url!.toString();
          password =
              Encryption.decryptEncryptionKey(ebookData.ebook.encryptionKey);
        });
        return Future.value();
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
    /*EbookScreenController ebookScreenController = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: Text(ebookScreenController.ebookScreenArgument.term.term.name),
        ),
        body: loading
            ? const LoadingWidget()
            : url.isNotEmpty
                ?
                // working, with selection, no annotiation, needs clearing wasm for releasing builds
                PdfViewer.uri(
                    Uri.parse(url),
                    passwordProvider: () => password,
                    params: PdfViewerParams(
                        enableTextSelection: true,
                        pageOverlaysBuilder: (context, pageRect, page) {
                          return [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                page.pageNumber.toString(),
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ];
                        },
                        loadingBannerBuilder:
                            (context, bytesDownloaded, totalBytes) {
                          return Center(
                            child: CircularProgressIndicator(
                              // totalBytes may not be available on certain case
                              value: totalBytes != null
                                  ? bytesDownloaded / totalBytes
                                  : null,
                              backgroundColor: Colors.grey,
                            ),
                          );
                        }),
                  )
                : const SizedBox());*/
  }
}
