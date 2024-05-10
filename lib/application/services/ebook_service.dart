import 'package:beta/application/services/database_service.dart';
import 'package:beta/domain/ebook_data.dart';

class EbookService {
  final DatabaseService databaseService;

  EbookService({required this.databaseService});

  Future addEbook(EbookData ebook) => databaseService
      .into(databaseService.ebooks)
      .insertOnConflictUpdate(ebook.ebook);
}
