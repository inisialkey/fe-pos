import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

/// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:pos/core/core.dart';
import 'package:pos/dependencies_injection.dart';
import 'package:pos/features/features.dart';

import '../../../../helpers/fake_path_provider_platform.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';
import '../../../../helpers/test_mock.mocks.dart';

void main() {
  late MockAuthRemoteDatasource mockAuthRemoteDatasource;
  late AuthRepositoryImpl authRepositoryImpl;
  late Login login;
  late GeneralToken generalToken;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    PathProviderPlatform.instance = FakePathProvider();
    await serviceLocator(
      isUnitTest: true,
      prefixBox: 'auth_repository_impl_test_',
    );
    mockAuthRemoteDatasource = MockAuthRemoteDatasource();
    authRepositoryImpl = AuthRepositoryImpl(mockAuthRemoteDatasource, sl());
    login = LoginResponse.fromJson(
      json.decode(jsonReader(pathLoginResponse200)) as Map<String, dynamic>,
    ).toEntity();

    generalToken = GeneralTokenResponse.fromJson(
      json.decode(jsonReader(pathGeneralTokenResponse200))
          as Map<String, dynamic>,
    ).toEntity();
  });

  group('general token', () {
    const generalTokenParams = GeneralTokenParams(
      clientId: 'apimock',
      clientSecret: 'apimock_secret',
    );
    test('should return general token when call data is successful', () async {
      // arrange
      when(
        mockAuthRemoteDatasource.generalToken(generalTokenParams),
      ).thenAnswer(
        (_) async => Right(
          GeneralTokenResponse.fromJson(
            json.decode(jsonReader(pathGeneralTokenResponse200))
                as Map<String, dynamic>,
          ),
        ),
      );

      // act
      final result = await authRepositoryImpl.generalToken(generalTokenParams);

      // assert
      verify(mockAuthRemoteDatasource.generalToken(generalTokenParams));

      expect(result, Right(generalToken));
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(
          mockAuthRemoteDatasource.generalToken(generalTokenParams),
        ).thenAnswer((_) async => const Left(ServerFailure('')));

        // act
        final result = await authRepositoryImpl.generalToken(
          generalTokenParams,
        );

        // assert
        verify(mockAuthRemoteDatasource.generalToken(generalTokenParams));
        expect(result, const Left(ServerFailure('')));
      },
    );
  });

  group('login', () {
    const loginParams = LoginParams(
      email: 'mudassir@lazycatlabs.com',
      password: 'pass123',
    );
    test('should return login when call data is successful', () async {
      // arrange
      when(mockAuthRemoteDatasource.login(loginParams)).thenAnswer(
        (_) async => Right(
          LoginResponse.fromJson(
            json.decode(jsonReader(pathLoginResponse200))
                as Map<String, dynamic>,
          ),
        ),
      );

      // act
      final result = await authRepositoryImpl.login(loginParams);

      // assert
      verify(mockAuthRemoteDatasource.login(loginParams));

      expect(result, Right(login));
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(
          mockAuthRemoteDatasource.login(loginParams),
        ).thenAnswer((_) async => const Left(ServerFailure('')));

        // act
        final result = await authRepositoryImpl.login(loginParams);

        // assert
        verify(mockAuthRemoteDatasource.login(loginParams));
        expect(result, const Left(ServerFailure('')));
      },
    );
  });
}
