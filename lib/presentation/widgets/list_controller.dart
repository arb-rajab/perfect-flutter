// ignore_for_file: invalid_use_of_protected_member

import 'package:beta/abstract/list_controller_base.dart';
import 'package:beta/application/service/network_service.dart';
import 'package:beta/constants/other_constants.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

abstract class ListController<T> implements ListControllerBase {
  bool loading = false;
  List items = [];
  String message = '';

  List itemsLoading = [];
  List itemsMessage = [];

  bool loadMoreVisibility = true;

  final Widget Function(BuildContext, int) itemBuilder;
  final State<StatefulWidget> state;
  bool remote;
  String plural;
  String indexUrl;

  ListController(
      {required this.itemBuilder,
      required this.state,
      this.remote = true,
      required this.plural,
      required this.indexUrl});

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

  int? getItemIndex(int id) {
    for (int c = 0; c < items.length; c++) {
      if (items[c]['id'].toString() == id.toString()) return c;
    }
    return null;
  }

  @override
  void deleteItem(int id) {
    int? index = getItemIndex(id);
    state.setState(() {
      items.removeAt(index!);
      itemsMessage.removeAt(index);
      itemsLoading.removeAt(index);
    });
  }

  @override
  Future? loadData({int offset = 0, bool refresh = false}) {
    if (remote) return _getRemoteData(offset: offset, refresh: refresh);
    return null;
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
              var newItems = body[plural];
              int oldCount = itemsLoading.length;
              for (int c = 0; c < newItems.length; c++) {
                itemsLoading.add(false);
                itemsMessage.add('');
              }
              items.addAll(newItems);
              if (items.length - oldCount < listItemsInitialCount) {
                loadMoreVisibility = false;
              }
            });
          }
        },
        onMessageReceived: (failureResponse) =>
            message = failureResponse.content,
        onConnectionFailed: () => message =
            StringConstant.noConnection.tr()).get(url: indexUrl, query: {
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
  void editItem(item) {
    /// [item] is null when the edit screen is closed without editting an item successfully
    if (item != null) {
      int index = getItemIndex(item['id'])!;
      items[index] = item;
    }
  }
}
