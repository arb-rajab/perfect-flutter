import 'package:beta/constants/string_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Show the loading dialog.
/// [context] - BuildContext to show it in.
/// [process] - Current progress value (0 to total).
/// [total] - Total value for 100% progress.
/// Returns a Future for when the dialog is dismissed.
Future<void> showLoadingDialog(
  BuildContext context, {
  required int process,
  required int total,
  GlobalKey<LoadingDialogState>? key, // Add this
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User cannot dismiss by tapping outside
    builder: (_) => LoadingDialog(key: key, process: process, total: total),
  );
}

/// Stateful dialog to update progress.
class LoadingDialog extends StatefulWidget {
  final int process;
  final int total;
  const LoadingDialog({super.key, required this.process, required this.total});

  @override
  LoadingDialogState createState() => LoadingDialogState();
}

class LoadingDialogState extends State<LoadingDialog> {
  late int currentProcess;
  late int totalValue;

  @override
  void initState() {
    super.initState();
    currentProcess = widget.process;
    totalValue = widget.total;
  }

  /// Call this method externally to update progress.
  void updateProgress(int newProcess) {
    setState(() {
      currentProcess = newProcess.clamp(0, totalValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = totalValue > 0 ? currentProcess / totalValue : 0.0;

    return AlertDialog(
      title: Text(StringConstant.loading.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: progressValue),
          const SizedBox(height: 16),
          Text('$currentProcess / $totalValue'),
        ],
      ),
      actions: [
        TextButton(
          onPressed:
              context.pop // Just closes dialog, process continues externally
          ,
          child: Text(StringConstant.hide.tr()),
        ),
      ],
    );
  }
}
