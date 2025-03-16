import 'package:beta/presentation/ebook/ebook_screen_controller.dart';
import 'package:beta/presentation/ebook/ebook_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';

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
    ebookScreenController = Get.put(EbookScreenController());
    super.initState();
  }

  @override
  void dispose() {
    ebookScreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const EbookWidget();
}
