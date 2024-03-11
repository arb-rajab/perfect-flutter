import 'package:beta/configs/colors.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VersionName extends HookConsumerWidget {
  const VersionName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var package = ref.read(packageRepositoryProvider);
    return Container(
      margin: const EdgeInsets.all(halfMargin),
      child: Text(
        package.getVersionName(),
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: primaryColorDark),
      ),
    );
  }
}
