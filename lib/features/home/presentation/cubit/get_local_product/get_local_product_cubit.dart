import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';

part 'get_local_product_state.dart';
part 'get_local_product_cubit.freezed.dart';

class GetLocalProductCubit extends Cubit<GetLocalProductState> {
  final GetLocalProduct _getLocalProduct;

  GetLocalProductCubit(this._getLocalProduct) : super(const _Loading());

  Future<void> getLocalProducts() async {
    emit(const _Loading());

    final data = await _getLocalProduct.call(NoParams());

    data.fold((l) {
      if (l is ServerFailure) {
        emit(_Failure(l.message ?? ''));
      }
    }, (r) => emit(_Success(r)));
  }
}
