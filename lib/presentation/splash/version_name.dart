import 'package:beta/configs/colors.dart';
import 'package:beta/configs/style.dart';
import 'package:beta/infrastructure/package_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class VersionName extends StatelessWidget {
  const VersionName({super.key});

  @override
  Widget build(BuildContext context) {
    PackageRepository package = Get.find();
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
