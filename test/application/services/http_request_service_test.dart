import 'package:beta/application/services/database_service.dart';
import 'package:beta/application/services/http_request_service.dart';
import 'package:test/test.dart';

import '../../common/tests.dart';

void main() {
  late HttpRequestService httpRequestService;

  setUp(() async {
    await initTests();
    httpRequestService = HttpRequestService(databaseService: databaseService);
  });

  group('HttpRequestService', () {
    test('getPendingRequests returns inserted requests', () async {
      const httpRequest = HttpRequest(
        id: 1,
        url: 'https://example.com',
        mapp: '{"key":"value"}',
      );

      // Insert the request directly into the database
      await databaseService
          .into(databaseService.httpRequests)
          .insert(httpRequest);

      final result = await httpRequestService.getPendingRequests();
      expect(result.length, 1);
      expect(result.first.id, httpRequest.id);
      expect(result.first.url, httpRequest.url);
      expect(result.first.mapp, httpRequest.mapp);
    });

    test('deletePendingRequest removes the request', () async {
      const httpRequest = HttpRequest(
        id: 2,
        url: 'https://delete.com',
        mapp: '{"delete":"me"}',
      );

      await databaseService
          .into(databaseService.httpRequests)
          .insert(httpRequest);

      // Ensure it exists
      var result = await httpRequestService.getPendingRequests();
      expect(result.any((r) => r.id == httpRequest.id), isTrue);

      // Delete
      final requestToDelete = result.firstWhere((r) => r.id == httpRequest.id);
      await httpRequestService.deletePendingRequest(requestToDelete);

      // Should not exist anymore
      result = await httpRequestService.getPendingRequests();
      expect(result.any((r) => r.id == httpRequest.id), isFalse);
    });
  });
}
