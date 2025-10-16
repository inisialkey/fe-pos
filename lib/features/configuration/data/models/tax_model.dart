// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'tax_model.freezed.dart';
// part 'tax_model.g.dart';

// @JsonEnum(alwaysCreate: true)
// enum TaxType {
//   @JsonValue('layanan')
//   layanan,

//   @JsonValue('pajak')
//   pajak;

//   bool get isLayanan => this == TaxType.layanan;
//   bool get isPajak => this == TaxType.pajak;
// }

// @freezed
// class TaxModel with _$TaxModel {
//   const factory TaxModel({
//     required String name,
//     required TaxType type,
//     required int value,
//   }) = _TaxModel;

//   factory TaxModel.fromJson(Map<String, dynamic> json) =>
//       _$TaxModelFromJson(json);
// }
