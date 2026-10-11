import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/home/home_screen_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TermUpdatesBanner extends StatelessWidget {
  final HomeScreenController homeScreenController;
  final bool dismissible;
  const TermUpdatesBanner(
    this.homeScreenController, {
    super.key,
    this.dismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      leading: Icon(Icons.system_update, color: Theme.of(context).primaryColor),
      content: Text(
        StringConstant.termsHaveUpdates.tr(
          args: [homeScreenController.updateableTermsCount.toString()],
        ),
      ),
      actions: [
        if (dismissible)
          TextButton(
            onPressed: homeScreenController.dismissUpdatesBanner,
            child: Text(StringConstant.later.tr()),
          ),
        if (homeScreenController.updatingAllTerms)
          const Padding(
            padding: EdgeInsets.all(8),
            child: SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          )
        else
          FilledButton.icon(
            key: const Key('updateAll'),
            onPressed: homeScreenController.updateAllTerms,
            icon: const Icon(Icons.system_update),
            label: Text(StringConstant.updateAll.tr()),
          ),
      ],
    );
  }
}
