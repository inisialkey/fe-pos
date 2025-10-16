import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/features/general/general.dart';

part 'diagnostic_response.freezed.dart';
part 'diagnostic_response.g.dart';

@freezed
sealed class DiagnosticResponse with _$DiagnosticResponse {
  const factory DiagnosticResponse({Diagnostic? diagnostic}) =
      _DiagnosticResponse;

  factory DiagnosticResponse.fromJson(Map<String, dynamic> json) =>
      _$DiagnosticResponseFromJson(json);
}
