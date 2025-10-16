import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';

class SyncDataPage extends StatefulWidget {
  const SyncDataPage({super.key});

  @override
  State<SyncDataPage> createState() => _SyncDataPageState();
}

class _SyncDataPageState extends State<SyncDataPage> {
  @override
  Widget build(BuildContext context) => Parent(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sinkronisasi Data',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SpacerV(value: Dimens.space16),
        BlocConsumer<SyncProductCubit, SyncProductState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              failure: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message), backgroundColor: Colors.red),
                );
              },
              success: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sync Product Success'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            );
          },

          builder: (context, state) => Button(
            title: Strings.of(context)!.syncDataProduct,
            width: Dimens.searchBar,
            onPressed: () => context.read<SyncProductCubit>().syncProducts(),
          ),
        ),
        SpacerV(value: Dimens.space16),
        Button(
          title: Strings.of(context)!.syncDataOrder,
          width: Dimens.searchBar,
          onPressed: () => context.read<SyncProductCubit>().syncProducts(),
        ),
      ],
    ),
  );
}
