import 'package:beta/common/screen_layout.dart';
import 'package:beta/domain/question_tag_data.dart';
import 'package:beta/presentation/home/question_tag_widget.dart';
import 'package:beta/presentation/home/terms_controller.dart';
import 'package:beta/presentation/widgets/list_controller.dart';
import 'package:get/instance_manager.dart';

class QuestionTagListingController extends ListController {
  TermsController termsController = Get.find();
  int numberOfOthers = 0;
  List<QuestionTagListingItem> questionTagListing = [];
  QuestionTagListingController(state)
      : super(
            itemBuilder: (context, index) => QuestionTagWidget(index: index),
            state: state,
            plural: '',
            indexUrl: '',
            fetch: () =>
                Future.value(Get.find<TermsController>().questionTagDatas),
            showLoadMore: false,
            showRefresh: false,
            remote: false,
            fromJson: null);

@override
  int get itemsPerRow => ScreenLayout.isExtraSmall(state.context)
      ? 1
      : ScreenLayout.isSmall(state.context)
          ? 2
          : ScreenLayout.isMedium(state.context)
              ? 3
              : 4;

  @override
  Future<List> Function()? get fetch => () {
        List array = [];
        if (Get.isRegistered<QuestionTagData>()) {
          array.add(Get.find<QuestionTagData>());
        }
        array.addAll(Get.find<TermsController>().questionTagDatas);
        if (numberOfOthers > 0) array.add(numberOfOthers);
        return Future.value(array);
      };
}

class QuestionTagListingItem {
  final QuestionTagData questionTagData;
  final int numberOfOthers;

  QuestionTagListingItem(
      {required this.questionTagData, required this.numberOfOthers});
}
