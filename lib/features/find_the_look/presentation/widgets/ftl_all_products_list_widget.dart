import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/product_tab_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../cubit/product_cart/product_cart_cubit.dart';
import '../../../../shared/widgets/products/product_item_widget.dart';

class FTLAllProductsListWidget extends StatefulWidget {
  final Function() onBack;
  final Function() onTryNow;

  const FTLAllProductsListWidget({
    super.key,
    required this.onBack,
    required this.onTryNow,
  });

  @override
  State<FTLAllProductsListWidget> createState() =>
      _FTLAllProductsListWidgetState();
}

class _FTLAllProductsListWidgetState extends State<FTLAllProductsListWidget> {
  SmilarProductTab? _selectedTab;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    _selectedTab = SmilarProductTab.smilarMakeup;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontalPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: widget.onBack,
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      IconPath.love,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      IconPath.cart,
                    ),
                  ],
                ),
              ],
            ),
          ),
          BlocBuilder<ProductCartCubit, ProductCartState>(
            builder: (context, state) {
              List<int> products = [];
              if (state is ProductCartLoaded) {
                products = state.products;
              }

              if (products.isEmpty) {
                return const SizedBox.shrink();
              }

              return SizedBox(
                height: 90,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.24),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                    itemCount: products.length,
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 50,
                        width: 50,
                        child: Stack(
                          children: [
                            Image.asset(
                              ImagePath.productExample,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: -3,
                              top: -3,
                              child: GestureDetector(
                                onTap: _onRemoveFromCart,
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontalPadding,
            ),
            child: Row(
              children: [
                _SmilarTabItemWidget(
                  tab: SmilarProductTab.smilarMakeup,
                  isSelected: _selectedTab == SmilarProductTab.smilarMakeup,
                  onTabSelected: _onTabSelected,
                ),
                _SmilarTabItemWidget(
                  tab: SmilarProductTab.smilarAccessories,
                  isSelected:
                      _selectedTab == SmilarProductTab.smilarAccessories,
                  onTabSelected: _onTabSelected,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.horizontalPadding,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lip Color",
                          style: TextStyle(
                            color: Color(0xFFE6E5E3),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                            color: Color(0xFFE6E5E3),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      itemCount: 10,
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        final isFirst = index == 0;
                        final isEnd = index == 10 - 1;

                        return Padding(
                          padding: EdgeInsets.only(
                            left: isFirst ? SizeConfig.horizontalPadding : 0,
                            right: isEnd ? SizeConfig.horizontalPadding : 0,
                          ),
                          child: ProductItemWidget(
                            onAddToCart: _onAddToCart,
                            onSelect: _onSelectProduct,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.horizontalPadding,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Eyeshadow",
                          style: TextStyle(
                            color: Color(0xFFE6E5E3),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                            color: Color(0xFFE6E5E3),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      itemCount: 10,
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        final isFirst = index == 0;
                        final isEnd = index == 10 - 1;

                        return Padding(
                          padding: EdgeInsets.only(
                            left: isFirst ? SizeConfig.horizontalPadding : 0,
                            right: isEnd ? SizeConfig.horizontalPadding : 0,
                          ),
                          child: ProductItemWidget(
                            onAddToCart: _onAddToCart,
                            onSelect: _onSelectProduct,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<ProductCartCubit, ProductCartState>(
            builder: (context, state) {
              List<int> products = [];
              if (state is ProductCartLoaded) {
                products = state.products;
              }

              if (products.isEmpty) {
                return const SizedBox.shrink();
              }

              return Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: SizeConfig.horizontalPadding,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        text: 'TRY NOW',
                        backgroundColor: Colors.black,
                        borderColor: Colors.white,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        onTap: widget.onTryNow,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ButtonWidget(
                        text: 'ADD ALL TO CART',
                        backgroundColor: Colors.white,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        onTap: _onAddAllToCart,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onTabSelected(SmilarProductTab tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  void _onAddToCart() {
    // add product to cart
    BlocProvider.of<ProductCartCubit>(context).addProduct();
  }

  void _onRemoveFromCart() {
    // remove product from cart
    BlocProvider.of<ProductCartCubit>(context).removeProduct();
  }

  void _onSelectProduct() {
    // TODO: select product
  }

  void _onAddAllToCart() {
    // TODO: add all to cart
  }
}

class _SmilarTabItemWidget extends StatelessWidget {
  final SmilarProductTab tab;
  final bool isSelected;
  final Function(SmilarProductTab) onTabSelected;

  const _SmilarTabItemWidget({
    required this.tab,
    required this.isSelected,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTabSelected(tab);
        },
        child: Container(
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.black,
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Text(
            SmilarProductTab.smilarMakeup.title.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
