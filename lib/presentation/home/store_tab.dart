import 'package:beta/constants/api_constant.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/product.dart';
import 'package:beta/presentation/home/product_widget.dart';
import 'package:beta/presentation/home/row_list.dart';
import 'package:beta/presentation/home/store_tab_controller.dart';
import 'package:beta/presentation/widgets/submit_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/instance_manager.dart';

class StoreTab extends StatefulWidget {
  const StoreTab({super.key});

  @override
  State<StatefulWidget> createState() => _StoreTabState();
}

class _StoreTabState extends State<StoreTab> {
  late StoreTabController controller;

  @override
  void initState() {
    Get.delete<StoreTabController>();
    controller = Get.put(StoreTabController(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: controller.canPop(),
        onPopInvokedWithResult: controller.onPopInvoked,
        child: Builder(builder: (context) {
if (controller.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.message.isNotEmpty) {
            return Center(
              child: Text(controller.message),
            );
          }
          if (controller.latestProducts.isNotEmpty ||
              controller.mostSeenProducts.isNotEmpty ||
              controller.productTypes.isNotEmpty ||
              controller.offers.isNotEmpty) {
            return ListView(
              shrinkWrap: true,
              children: [
                if (controller.latestProducts.isNotEmpty)
                  RowList(
                    label: StringConstant.latestProducts.tr(),
                    items: controller.latestProducts,
                    loadMoreApi: ApiConstant.latestProducts,
                  ),
                if (controller.mostSeenProducts.isNotEmpty)
                  RowList(
                    label: StringConstant.mostSeenProducts.tr(),
                    items: controller.mostSeenProducts,
                    loadMoreApi: ApiConstant.mostSeenProducts,
                  ),
                if (controller.offers.isNotEmpty)
                  RowList(
                    label: StringConstant.offers.tr(),
                    items: controller.offers,
                    loadMoreApi: ApiConstant.offers,
                  ),
                ...controller.productTypes.map((productType) => RowList(
                      label: productType.name.value!,
                      items: [...productType.subtypes, ...productType.products],
                      loadMoreApi: ApiConstant.productTypes.replaceFirst(
                          '(PRODUCT_TYPE)', productType.id.value.toString()),
                      typeId: productType.id,
                    )),
                if (controller.products.isNotEmpty)
                  RowList(
                      label: StringConstant.others.tr(),
                      items: controller.products,
                      loadMoreApi: ApiConstant.productTypesProducts
                          .replaceFirst(
                              '(PRODUCT_TYPE)',
                              controller.typeId == null
                                  ? '0'
                                  : controller.typeId!.value.toString()))
              ],
            );
          }
          if (controller.products.isEmpty) return const Center();
          return ListView(
            shrinkWrap: true,
            children: [
              MasonryGridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                itemCount: controller.products.length,
                physics: const NeverScrollableScrollPhysics(),
                // mainAxisSpacing: 4,
                // crossAxisSpacing: 4,
                itemBuilder: (context, index) {
                  Product product = controller.products[index];
                  return ProductWidget(
                    product: product,
                  );
                },
              ),
              if (controller.newProducts.length == 10)
                SubmitButton(
                    text: StringConstant.loadMore.tr(),
                    loading: controller.loading,
                    onSubmit: () =>
                        controller.getData(api: controller.listingApis.last))
            ],
          );
        }));
  }
}
