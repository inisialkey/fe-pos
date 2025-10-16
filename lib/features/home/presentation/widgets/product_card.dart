import 'package:flutter/material.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';
import 'package:pos/utils/utils.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  final VoidCallback onCartButton;

  const ProductCard({
    required this.data,
    required this.onCartButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      // context.read<CheckoutBloc>().add(CheckoutEvent.addItem(data));
    },
    child: Container(
      padding: EdgeInsets.all(Dimens.space16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Palette.subText),
          borderRadius: BorderRadius.circular(Dimens.space18),
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(Dimens.space12),
                margin: EdgeInsets.only(top: Dimens.space20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.disabled.withValues(alpha: 0.4),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.space40),
                  ),
                  child: data.image!.isEmpty
                      ? const Icon(Icons.food_bank_outlined)
                      : Image.network(
                          data.image!.contains('http')
                              ? data.image!
                              : '${const String.fromEnvironment('BASE_URL')}/${data.image}',
                          width: Dimens.space50,
                          height: Dimens.space50,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const Spacer(),
              FittedBox(
                child: Text(
                  data.name ?? '-',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SpacerV(value: Dimens.space8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        data.category?.name ?? '-',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Palette.subtitle,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        data.price!.toIntegerFromText.currencyFormatRp,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // BlocBuilder<CheckoutBloc, CheckoutState>(
          //   builder: (context, state) => state.maybeWhen(
          //     orElse: () => const SizedBox(),
          //     loaded: (products, discount, tax, service) {
          //       // if (qty == 0) {
          //       //   return Align(
          //       //     alignment: Alignment.topRight,
          //       //     child: Container(
          //       //       width: 36,
          //       //       height: 36,
          //       //       padding: const EdgeInsets.all(6),
          //       //       decoration: const BoxDecoration(
          //       //         borderRadius:
          //       //             BorderRadius.all(Radius.circular(9.0)),
          //       //         color: AppColors.primary,
          //       //       ),
          //       //       child: Assets.icons.shoppingBasket.svg(),
          //       //     ),
          //       //   );
          //       // }
          //       return products.any((element) => element.product == data)
          //           ? products
          //                         .firstWhere(
          //                           (element) => element.product == data,
          //                         )
          //                         .quantity >
          //                     0
          //                 ? Align(
          //                     alignment: Alignment.topRight,
          //                     child: Container(
          //                       width: 40,
          //                       height: 40,
          //                       padding: const EdgeInsets.all(6),
          //                       decoration: const BoxDecoration(
          //                         borderRadius: BorderRadius.all(
          //                           Radius.circular(9.0),
          //                         ),
          //                         color: AppColors.primary,
          //                       ),
          //                       child: Center(
          //                         child: Text(
          //                           products
          //                               .firstWhere(
          //                                 (element) => element.product == data,
          //                               )
          //                               .quantity
          //                               .toString(),
          //                           style: const TextStyle(
          //                             color: Colors.white,
          //                             fontSize: 20,
          //                             fontWeight: FontWeight.bold,
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   )
          //                 : Align(
          //                     alignment: Alignment.topRight,
          //                     child: Container(
          //                       width: 36,
          //                       height: 36,
          //                       padding: const EdgeInsets.all(6),
          //                       decoration: const BoxDecoration(
          //                         borderRadius: BorderRadius.all(
          //                           Radius.circular(9.0),
          //                         ),
          //                         color: AppColors.primary,
          //                       ),
          //                       child: Assets.icons.shoppingBasket.svg(),
          //                     ),
          //                   )
          //           : Align(
          //               alignment: Alignment.topRight,
          //               child: Container(
          //                 width: 36,
          //                 height: 36,
          //                 padding: const EdgeInsets.all(6),
          //                 decoration: const BoxDecoration(
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(9.0),
          //                   ),
          //                   color: AppColors.primary,
          //                 ),
          //                 child: Assets.icons.shoppingBasket.svg(),
          //               ),
          //             );
          //     },
          //   ),
          // ),
        ],
      ),
    ),
  );
}
