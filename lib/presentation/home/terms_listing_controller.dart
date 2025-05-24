import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_label_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/common/screen_layout.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/term_widget.dart';
import 'package:beta/presentation/widgets/list_controller.dart';
import 'package:get/instance_manager.dart';

class TermsListingController extends ListController {
  TermLabelService termLabelService = Get.find();
  TermService termService = Get.find();
  TermTagService termTagService = Get.find();

  List<TermData> termsListing = [];
  bool reload = false;
  List<TermLabel> termsLabels = [];
  TermsListingController(state)
      : super(
            itemBuilder: (context, index) => TermWidget(
                  index: index,
                ),
            state: state,
            plural: 'terms',
            indexUrl: '',
            remote: false,
            fetch: () => Future(() => []),
            showRefresh: false,
            fromJson: TermData.fromJson,
            showLoadMore: false);

  @override
  int get itemsPerRow => ScreenLayout.isExtraSmall(state.context)
      ? 1
      : ScreenLayout.isSmall(state.context)
          ? 2
          : ScreenLayout.isMedium(state.context)
              ? 3
              : 4;

  Future<void> refresh() async {
    reload = true;
    await fetch?.call();
    reload = false;
  }

  // @override
  // Future<List> Function()? get fetch => () async {
  //       List<TermData> terms;
  //       if (termsListing.isEmpty) {
  //         terms = await termService.getFirstLayerTerms();
  //       } else {
  //         TermData termData = Get.find();
  //         terms = await termService.getSubTerms(termData.term.id);
  //         // if (!reload) termsListing.add(termData);
  //       }
  //       if (Get.isRegistered<TermTag>()) {
  //         TermTag tag = Get.find();
  //         terms =
  //             terms.where((element) => element.tagId!.value == tag.id).toList();
  //         await Get.delete<TermTag>();
  //       }
  //       // if (terms.length == 1 &&
  //       //     terms[0].term.type == TermType.term &&
  //       //     Get.isRegistered<BrowseTermsTabController>() &&
  //       //     !Get.find<BrowseTermsTabController>().backPressed) {
  //       //   await Get.delete<TermData>();
  //       //   Get.put(terms[0]);
  //       //   termsListing.add(terms[0]);
  //       //   // ignore: recursive_getters
  //       //   return fetch!();
  //       // }
  //       return Future.value(terms);
  //     };

  @override
  Function? get onPostFetch => () async {
        List<TermData> termDatas = items.map((e) => e as TermData).toList();
        termsLabels = await termLabelService.getTermsLabels(termDatas);
      };
}
