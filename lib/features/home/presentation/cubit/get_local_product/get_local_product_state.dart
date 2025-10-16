part of 'get_local_product_cubit.dart';

@freezed
class GetLocalProductState with _$GetLocalProductState {
  const factory GetLocalProductState.loading() = _Loading;
  const factory GetLocalProductState.success(List<Product> data) = _Success;
  const factory GetLocalProductState.failure(String message) = _Failure;
}
