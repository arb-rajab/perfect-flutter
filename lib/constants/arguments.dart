import 'dart:async';

import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/coupon_type.dart';
import 'package:beta/domain/question_data.dart';
import 'package:beta/domain/term_data.dart';
import 'package:beta/domain/value/id.dart';
import 'package:beta/domain/value/title.dart' as t;
import 'package:beta/presentation/questions/questions_screen.dart';

class ChooseTermScreenArgument {
  final Coupon coupon;
  final List<TermData> terms;
  final bool free;
  final CouponType couponType;

  ChooseTermScreenArgument(
      {required this.coupon,
      required this.terms,
      required this.free,
      required this.couponType});
}

class QuestionMediasScreenArgument {
  final List<QuestionMedia> questionMedias;

  QuestionMediasScreenArgument({required this.questionMedias});
}

class QuestionsScreenArgument {
  final String? query;
  final QuestionScreenSource source;
  final Id? sourceId;
  final Id resourceTermId;
  final t.Title title;
  TermData? termData;

  QuestionsScreenArgument(
      {required this.query,
      required this.source,
      required this.sourceId,
      required this.resourceTermId,
      required this.title,
      this.termData});
}

class QuestionsReportScreenArgument {
  final List<QuestionData> questions;
  final Timer timer;

  QuestionsReportScreenArgument({required this.questions, required this.timer});
}

class WebScreenArgument {
  final Uri uri;
  final t.Title title;
  final bool connected;

  WebScreenArgument(
      {required this.connected, required this.uri, required this.title});
}

class EbookScreenArgument {
  final Ebook ebook;
  final TermData term;

  EbookScreenArgument({required this.ebook, required this.term});
}

class YoutubeVideoScreenArgument {
  final String videoId;
  final TermData termData;

  YoutubeVideoScreenArgument({required this.videoId, required this.termData});
}

class DiscussionScreenArgument {
  final int itemId;
  final String itemType;
  final String itemName;
  final bool commentEnabled;

  DiscussionScreenArgument(
      {required this.itemId,
      required this.itemType,
      required this.itemName,
      this.commentEnabled = true});
}
