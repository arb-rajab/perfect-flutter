// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/abstract/list_controller_base.dart';
import 'package:beta/application/services/network_service.dart';
import 'package:beta/constants/other_constants.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

abstract class ListController<T> implements ListControllerBase {
  bool loading = false;
  List<T> items = [];
  String message = '';
  int itemsPerRow;

  List itemsLoading = [];
  List itemsMessage = [];

  bool loadMoreVisibility = true;

  final Widget Function(BuildContext, int) itemBuilder;
  final State<StatefulWidget> state;
  bool remote;
  String? plural;
  String? indexUrl;
  Future<List> Function()? fetch;
  Function()? onConnectionSucceed;
  Function? onPreFetch;
  Function? onPostFetch;
  final bool showLoadMore;
  final bool showRefresh;
  final T Function(Map<String, dynamic> json) fromJson;

  ListController(
      {required this.itemBuilder,
      required this.state,
      required this.plural,
      required this.indexUrl,
      required this.fetch,
      required this.fromJson,
      this.onConnectionSucceed,
      this.remote = true,
      this.showLoadMore = true,
      this.showRefresh = true,
      this.itemsPerRow = 1});

  Future init({int offset = 0, bool refresh = false}) async {
    if (refresh) {
      state.setState(() {
        loadMoreVisibility = refresh;
      });
    }

    preListFetching(offset);
    await loadData(offset: offset, refresh: refresh);
    postListFetching();
  }

  void preListFetching(int offset) {
    if (offset == 0) {
      loading = true;
      message = '';
    } else {
      state.setState(() {
        loading = true;
        message = '';
      });
    }
  }

  void postListFetching() {
    if (state.mounted) {
      state.setState(() {
        if (items.isNotEmpty) message = '';
        loading = false;
      });
    }
  }

  void preItemLoading(int index) {
    state.setState(() {
      itemsLoading[index] = true;
    });
  }

  void postItemLoading(int index) {
    state.setState(() {
      itemsLoading[index] = false;
    });
  }

  @override
  void deleteItem(int index) {
    state.setState(() {
      items.removeAt(index);
      itemsMessage.removeAt(index);
      itemsLoading.removeAt(index);
    });
  }

  @override
  Future? loadData({int offset = 0, bool refresh = false}) async {
    if (remote) {
      return _getRemoteData(offset: offset, refresh: refresh);
    } else {
      List<T> fetched = (await fetch!.call() as List<T>);
      state.setState(() {
        if (onPreFetch != null) onPreFetch!.call();
        items.clear();
        items.addAll(fetched);
        itemsMessage.clear();
        itemsMessage.addAll(List.filled(items.length, ''));
        itemsLoading.clear();
        itemsLoading.addAll(List.filled(items.length, false));
        if (onPostFetch != null) onPostFetch!.call();
      });
    }
  }

  Future? _getRemoteData({required int offset, required bool refresh}) {
    return NetworkService(this.state.context,
            onConnectionSucceed: (body) {
              if (state.mounted) {
                state.setState(() {
                  if (refresh) {
                    items.clear();
                    itemsLoading.clear();
                    itemsMessage.clear();
                  }
                  List newItems = body[plural];
                  int oldCount = itemsLoading.length;
                  for (int c = 0; c < newItems.length; c++) {
                    itemsLoading.add(false);
                    itemsMessage.add('');
                  }
                  items.addAll(newItems.map((e) => fromJson(e)).toList());
                  if (items.length - oldCount < listItemsInitialCount) {
                    loadMoreVisibility = false;
                  }
                });
              }
              if (onConnectionSucceed != null) onConnectionSucceed?.call();
            },
            onMessageReceived: (failureResponse) =>
                message = failureResponse.content,
            onConnectionFailed: () =>
                message = StringConstant.noConnection.tr(),
            onPreConnect: () {},
            onPostConnect: () {})
        .get(url: indexUrl!, query: {
      'limit': listItemsInitialCount.toString(),
      'offset': offset.toString()
    });
  }

  @override
  void addItem(item) {
    if (items.isNotEmpty) {
      items.insert(0, item);
      itemsMessage.insert(0, '');
      itemsLoading.insert(0, false);
    } else {
      items.add(item);
      itemsMessage.add('');
      itemsLoading.add(false);
    }
  }

  @override
  void editItem(item, index) {
    /// [item] is null when the edit screen is closed without editting an item successfully
    if (item != null) {
      items[index] = item;
    }
  }
}
