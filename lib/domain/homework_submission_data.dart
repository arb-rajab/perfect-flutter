class HomeworkSubmissionData {
  final int id;
  final String? uuid;
  final int termId;
  final String? title;
  final String? note;
  final String status;
  final String? reviewNote;
  final String? mark;
  final String? submittedAt;
  final String? reviewedAt;

  HomeworkSubmissionData({
    required this.id,
    this.uuid,
    required this.termId,
    this.title,
    this.note,
    required this.status,
    this.reviewNote,
    this.mark,
    this.submittedAt,
    this.reviewedAt,
  });

  static HomeworkSubmissionData fromJson(Map<String, dynamic> json) =>
      HomeworkSubmissionData(
        id: json['id'],
        uuid: json['uuid'],
        termId: json['termId'],
        title: json['title'],
        note: json['note'],
        status: json['status'] ?? 'pending',
        reviewNote: json['reviewNote'],
        mark: json['mark'],
        submittedAt: json['submitted_at'],
        reviewedAt: json['reviewed_at'],
      );

  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';
}
