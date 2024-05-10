import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/term_service.dart';
import 'package:beta/application/services/term_tag_service.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/presentation/home/terms_listing_controller.dart';
import 'package:get/instance_manager.dart';

class BrowseTermsTabController extends TermsListingController {
  TermTagService termTagService = Get.find();
  TermService termService = Get.find();
  BrowseTermsTabController(super.state);

  @override
  Future<List> Function()? get fetch => () async {
        if (termsTags.isEmpty) {
          List<TermData> terms;
          termsListing.isEmpty
              ? terms = await termService.getFirstLayerTerms()
              : terms =
                  await termService.getSubTerms(Get.find<TermData>().term.id);
          if (!reload) termsListing.add(terms);
          termDatas = terms;
          return Future.value(terms);
        }
        return Future.value([...termsTags, ...termTagButtons]);
      };

  @override
  Function? get onPostFetch => () async {
        if (items is List<TermData>) {
          termsTags =
              await termTagService.getTermsTags(items as List<TermData>);
          super.onPostFetch!();
        }
      };
}
