import 'package:beta/presentation/ebook/ebook_screen_controller.dart';
import 'package:beta/presentation/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

class EbookScreen extends StatefulWidget {
  static const String route = '/ebook';

  const EbookScreen({super.key});

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
  late EbookScreenController ebookScreenController;

  @override
  void initState() {
    Get.delete<EbookScreenController>();
    ebookScreenController = Get.put(EbookScreenController(this));
    super.initState();
  }

  @override
  void dispose() async {
    ebookScreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!ebookScreenController.fileLoaded) return const Center();
    return DocumentView(onCreated: ebookScreenController.onCreated);
  }
}
