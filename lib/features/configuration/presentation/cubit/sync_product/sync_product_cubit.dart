import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';

part 'sync_product_state.dart';
part 'sync_product_cubit.freezed.dart';

class SyncProductCubit extends Cubit<SyncProductState> {
  final SyncProduct _syncProduct;
  SyncProductCubit(this._syncProduct) : super(const _Loading());

  Future<void> syncProducts() async {
    emit(const _Loading());

    // Call sync usecase (sudah handle semua flow)
    final result = await _syncProduct.call(NoParams());

    result.fold(
      (l) {
        if (l is ServerFailure) {
          emit(_Failure(l.message ?? ''));
        }
      },
      (r) {
        // Berhasil sync!
        emit(const _Success());
      },
    );
  }
}
