import 'package:beta/application/services/database_service.dart';
import 'package:drift/drift.dart';

class HttpRequestService {
  final DatabaseService databaseService;

  HttpRequestService({required this.databaseService});

  Future<List<HttpRequest>> getPendingRequests() =>
      databaseService.select(databaseService.httpRequests).get();

  Future deletePendingRequest(HttpRequest httpRequest) =>
      databaseService.httpRequests.deleteOne(httpRequest);
}
