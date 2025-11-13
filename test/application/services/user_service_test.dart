import 'package:beta/constants/key_value_constant.dart';
import 'package:beta/infrastructure/key_value_repository.dart';
import 'package:beta/application/services/user_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockKeyValue extends Mock implements KeyValue {}

void main() {
  group('UserService', () {
    late MockKeyValue mockKeyValue;
    late UserService userService;

    setUp(() {
      mockKeyValue = MockKeyValue();
      userService = UserService(keyValue: mockKeyValue);
    });

    test('setId stores id as string in KeyValue', () async {
      when(() => mockKeyValue.setString(any(), any()))
          .thenAnswer((_) async => Future.value());

      await userService.setId(123);

      verify(() => mockKeyValue.setString(KeyValueConstant.userId, '123'))
          .called(1);
    });

    test('getId returns stored user id string', () {
      when(() => mockKeyValue.getString(KeyValueConstant.userId))
          .thenReturn('456');

      final id = userService.getId();

      expect(id, '456');
      verify(() => mockKeyValue.getString(KeyValueConstant.userId)).called(1);
    });

    test('tokenUploaded returns stored bool or false if null', () {
      when(() => mockKeyValue.getBool(KeyValueConstant.tokenUploaded, false))
          .thenReturn(true);
      expect(userService.tokenUploaded(), true);

      when(() => mockKeyValue.getBool(KeyValueConstant.tokenUploaded, false))
          .thenReturn(false);
      expect(userService.tokenUploaded(), false);
    });

    test('setTokenUploaded stores bool in KeyValue', () async {
      when(() => mockKeyValue.setBool(any(), any()))
          .thenAnswer((_) async => Future.value());

      await userService.setTokenUploaded(true);
      verify(() => mockKeyValue.setBool(KeyValueConstant.tokenUploaded, true))
          .called(1);

      await userService.setTokenUploaded(false);
      verify(() => mockKeyValue.setBool(KeyValueConstant.tokenUploaded, false))
          .called(1);
    });

    test('allTopicSubscribed returns stored bool or false if null', () {
      when(() => mockKeyValue.getBool(
          KeyValueConstant.isAllTokenSubscribed, false)).thenReturn(true);
      expect(userService.allTopicSubscribed(), true);

      when(() => mockKeyValue.getBool(
          KeyValueConstant.isAllTokenSubscribed, false)).thenReturn(false);
      expect(userService.allTopicSubscribed(), false);
    });

    test('allNewsSubscribed returns stored bool or false if null', () {
      when(() =>
              mockKeyValue.getBool(KeyValueConstant.isAllNewsSubscribed, false))
          .thenReturn(true);
      expect(userService.allNewsSubscribed(), true);

      when(() =>
              mockKeyValue.getBool(KeyValueConstant.isAllNewsSubscribed, false))
          .thenReturn(false);
      expect(userService.allNewsSubscribed(), false);
    });

    test('setAllTopicSubscribed stores bool in KeyValue', () async {
      when(() => mockKeyValue.setBool(any(), any()))
          .thenAnswer((_) async => Future.value());

      await userService.setAllTopicSubscribed(true);
      verify(() =>
              mockKeyValue.setBool(KeyValueConstant.isAllTokenSubscribed, true))
          .called(1);

      await userService.setAllTopicSubscribed(false);
      verify(() => mockKeyValue.setBool(
          KeyValueConstant.isAllTokenSubscribed, false)).called(1);
    });

    test('setAllNewsSubscribed stores bool in KeyValue', () async {
      when(() => mockKeyValue.setBool(any(), any()))
          .thenAnswer((_) async => Future.value());

      await userService.setAllNewsSubscribed(true);
      verify(() =>
              mockKeyValue.setBool(KeyValueConstant.isAllNewsSubscribed, true))
          .called(1);

      await userService.setAllNewsSubscribed(false);
      verify(() =>
              mockKeyValue.setBool(KeyValueConstant.isAllNewsSubscribed, false))
          .called(1);
    });
  });
}
