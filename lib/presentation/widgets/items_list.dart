import 'package:beta/constants/string_constant.dart';
import 'package:beta/presentation/widgets/form_message_widget.dart';
import 'package:beta/presentation/widgets/list_controller.dart';
import 'package:beta/presentation/widgets/loading_widget.dart';
import 'package:beta/presentation/widgets/message_widget.dart';
import 'package:beta/presentation/widgets/no_items_widget.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemsList extends StatefulWidget {
  final ListController controller;
  final bool remoteData;

  const ItemsList(
      {super.key, required this.controller, this.remoteData = true});

  @override
  State<StatefulWidget> createState() => _ItemListState();

  // @override
  // State<StatefulWidget> createState() => _ItemListState();
}

class _ItemListState extends State<ItemsList> {
  @override
  void initState() {
    widget.controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.remoteData && widget.controller.showRefresh) {
      return RefreshIndicator(
          child: _ListLocale(widget.controller),
          onRefresh: () {
            if (widget.controller.loading) return Future.value();
            return widget.controller.init(refresh: true);
          });
    }
    return _ListLocale(widget.controller);
  }
}

class _ListLocale extends StatefulWidget {
  final ListController controller;

  const _ListLocale(this.controller);

  @override
  State<StatefulWidget> createState() => _ListLocaleState();
}

class _ListLocaleState extends State<_ListLocale> {
  @override
  Widget build(BuildContext context) {
    var controller = widget.controller;
    if (controller.items.isEmpty) {
      if (controller.loading) return const LoadingWidget();
      if (controller.message != '') return MessageWidget(controller.message);
      return const NoItemsWidget();
    }
    if (controller.itemsPerRow == 1) {
      return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            if (controller.message.isNotEmpty)
              FormMessageWidget(
                  message: controller.message,
                  onDismiss: () => setState(() {
                        controller.message = '';
                      })),
            ListView.builder(
                itemBuilder: controller.itemBuilder,
                itemCount: controller.items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics()),
            if (controller.loadMoreVisibility && controller.showLoadMore)
              SubmitButton(
                  text: StringConstant.loadMore.tr(),
                  loading: controller.loading,
                  onSubmit: () =>
                      controller.init(offset: controller.items.length))
          ]);
    } else {
      return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            if (controller.message.isNotEmpty)
              FormMessageWidget(
                  message: controller.message,
                  onDismiss: () => setState(() {
                        controller.message = '';
                      })),
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: controller.itemsPerRow),
                itemBuilder: controller.itemBuilder,
                itemCount: controller.items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics()),
            if (controller.loadMoreVisibility && controller.showLoadMore)
              SubmitButton(
                  text: StringConstant.loadMore.tr(),
                  loading: controller.loading,
                  onSubmit: () =>
                      controller.init(offset: controller.items.length))
          ]);
    }
  }
}
