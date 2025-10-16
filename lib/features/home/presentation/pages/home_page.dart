import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';
import 'package:pos/features/home/presentation/widgets/product_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _conSearch = TextEditingController();

  void onCategoryTap(int index) {
    _conSearch.clear();
    setState(() {});
  }

  @override
  void initState() {
    context.read<GetLocalProductCubit>().getLocalProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Parent(
    child: Hero(
      tag: 'confirmationScreen',
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.all(Dimens.space16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HomeTitleHeader(
                        controller: _conSearch,
                        onChanged: (value) {},
                      ),
                      SpacerV(value: Dimens.space24),
                      TabMenu(
                        title: const ['Semua', 'Makanan', 'Minuman', 'Snack'],
                        initialTabIndex: 0,
                        tabViews: [
                          SizedBox(
                            child:
                                BlocBuilder<
                                  GetLocalProductCubit,
                                  GetLocalProductState
                                >(
                                  builder: (context, state) => state.maybeWhen(
                                    orElse: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    success: (data) {
                                      if (data.isEmpty) {
                                        return const Center(
                                          child: Text('No Items'),
                                        );
                                      }
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: data.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 0.85,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 30.0,
                                              mainAxisSpacing: 30.0,
                                            ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                              data: data[index],
                                              onCartButton: () {},
                                            ),
                                      );
                                    },
                                  ),
                                ),
                          ),
                          SizedBox(
                            child:
                                BlocBuilder<
                                  GetLocalProductCubit,
                                  GetLocalProductState
                                >(
                                  builder: (context, state) => state.maybeWhen(
                                    orElse: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    success: (data) {
                                      if (data.isEmpty) {
                                        return const Center(
                                          child: Text('No Items'),
                                        );
                                      }
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: data
                                            .where(
                                              (element) =>
                                                  element.category!.name! ==
                                                  'Makanan',
                                            )
                                            .toList()
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 0.85,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 30.0,
                                              mainAxisSpacing: 30.0,
                                            ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                              data: data
                                                  .where(
                                                    (element) =>
                                                        element
                                                            .category!
                                                            .name! ==
                                                        'Makanan',
                                                  )
                                                  .toList()[index],
                                              onCartButton: () {},
                                            ),
                                      );
                                    },
                                  ),
                                ),
                          ),
                          SizedBox(
                            child:
                                BlocBuilder<
                                  GetLocalProductCubit,
                                  GetLocalProductState
                                >(
                                  builder: (context, state) => state.maybeWhen(
                                    orElse: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    success: (data) {
                                      if (data.isEmpty) {
                                        return const Center(
                                          child: Text('No Items'),
                                        );
                                      }
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: data
                                            .where(
                                              (element) =>
                                                  element.category!.name! ==
                                                  'Minuman',
                                            )
                                            .toList()
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 0.85,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 30.0,
                                              mainAxisSpacing: 30.0,
                                            ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                              data: data
                                                  .where(
                                                    (element) =>
                                                        element
                                                            .category!
                                                            .name! ==
                                                        'Minuman',
                                                  )
                                                  .toList()[index],
                                              onCartButton: () {},
                                            ),
                                      );
                                    },
                                  ),
                                ),
                          ),
                          SizedBox(
                            child:
                                BlocBuilder<
                                  GetLocalProductCubit,
                                  GetLocalProductState
                                >(
                                  builder: (context, state) => state.maybeWhen(
                                    orElse: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    success: (data) {
                                      if (data.isEmpty) {
                                        return const Center(
                                          child: Text('No Items'),
                                        );
                                      }
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: data
                                            .where(
                                              (element) =>
                                                  element.category!.name! ==
                                                  'Snack',
                                            )
                                            .toList()
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 0.85,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 30.0,
                                              mainAxisSpacing: 30.0,
                                            ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                              data: data
                                                  .where(
                                                    (element) =>
                                                        element
                                                            .category!
                                                            .name! ==
                                                        'Snack',
                                                  )
                                                  .toList()[index],
                                              onCartButton: () {},
                                            ),
                                      );
                                    },
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(Dimens.space24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Orders #1',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        SpacerV(value: Dimens.space8),
                        Row(
                          children: [
                            Button(
                              width: Dimens.space100 + Dimens.space20,
                              title: 'Dine In',
                              onPressed: () {},
                            ),
                            SpacerH(value: Dimens.space8),
                            ButtonBorder(title: 'To Go', onPressed: () {}),
                          ],
                        ),
                        SpacerV(value: Dimens.space16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            SpacerH(value: Dimens.space130),
                            SizedBox(
                              width: Dimens.space50,
                              child: Text(
                                'Qty',
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                'Price',
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SpacerV(value: Dimens.space8),
                        const Divider(),
                        SpacerV(value: Dimens.space8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
