import 'package:flutter/cupertino.dart';
import 'package:mockito/annotations.dart';
import 'package:pos/features/features.dart';

@GenerateMocks([
  AuthRepository,
  AuthRemoteDatasource,
  UsersRepository,
  UsersRemoteDatasource,
])
@GenerateNiceMocks([MockSpec<BuildContext>()])
void main() {}
