part of 'sync_product_cubit.dart';

@freezed
class SyncProductState with _$SyncProductState {
  const factory SyncProductState.loading() = _Loading;
  const factory SyncProductState.success() = _Success;
  const factory SyncProductState.failure(String message) = _Failure;
}
