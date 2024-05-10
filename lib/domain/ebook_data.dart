import 'package:beta/application/services/database_service.dart';

class EbookData {
  Ebook ebook;
  Uri? url;
  EbookData(this.ebook, {this.url});

  static EbookData fromJson(Map<String, dynamic> json) {
    EbookData termData = EbookData(Ebook.fromJson(json));
    termData.url = Uri.parse(json['url']);
    return termData;
  }

  Map toJson() => {...ebook.toJson(), 'url': url!.toString()};

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is EbookData && other.ebook == ebook);

  @override
  int get hashCode => Object.hash(ebook, url);
}
