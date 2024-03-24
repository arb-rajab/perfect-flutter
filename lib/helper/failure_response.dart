enum MessageType { warning, error }

class FailureResponse {
  late MessageType type;
  late String content;
  int? code;

  FailureResponse({required this.type, required this.content, this.code});
}
