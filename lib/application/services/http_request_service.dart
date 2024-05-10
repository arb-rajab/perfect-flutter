import 'package:beta/application/services/database_service.dart';
import 'package:drift/drift.dart';

class HttpRequestService {
  final DatabaseService databaseService;

  HttpRequestService({required this.databaseService});

  //TODO add test
  Future<List<HttpRequest>> getPendingRequests() =>
      databaseService.select(databaseService.httpRequests).get();

  //TODO add test
  Future deletePendingRequest(HttpRequest httpRequest) =>
      databaseService.httpRequests.deleteOne(httpRequest);
}
