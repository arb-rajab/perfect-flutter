import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/product.dart';
import 'package:beta/domain/product_type.dart';
import 'package:beta/domain/value/product_type_id.dart';
import 'package:beta/presentation/home/product_widget.dart';
import 'package:beta/presentation/home/store_tab_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class RowList extends StatelessWidget {
  final String label;
  final List items;
  final String loadMoreApi;
  final ProductTypeId? typeId;

  final StoreTabController controller = Get.find();

  RowList(
      {super.key,
      required this.label,
      required this.items,
      required this.loadMoreApi,
      this.typeId});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  StoreTabController storeTabController = Get.find();
                  storeTabController.typeId = typeId;
                  controller.getData(api: loadMoreApi);
                },
                child: Text(StringConstant.loadMore.tr()),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              dynamic item = items[index];
              if (item is Product) return ProductWidget(product: item);
              if (item is ProductType) {
                return GestureDetector(
                  onTap: () {
                    StoreTabController storeTabController = Get.find();
                    storeTabController.typeId = item.id;
                    controller.getData(
                        api: ApiConstant.productTypes.replaceFirst(
                            '(PRODUCT_TYPE)', item.id.value.toString()));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 200,
                      width: 150,
                      child: Center(
                        child: Text(item.name.value!),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
