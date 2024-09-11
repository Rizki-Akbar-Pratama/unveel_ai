import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/toast_info.dart';
import '../../../../service_locator.dart';
import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/object_parsing.dart';
import '../../../../shared/extensions/toast_type_parsing.dart';
import '../cubit/product_cart/product_cart_cubit.dart';

const _eyeTypes = [
  'One',
  'Dual',
  'Tri',
  'Quadra',
  "Penta",
];

class FTLMakeupWidget extends StatefulWidget {
  final Function() onViewAll;

  const FTLMakeupWidget({
    super.key,
    required this.onViewAll,
  });

  @override
  State<FTLMakeupWidget> createState() => _FTLMakeupWidgetState();
}

class _FTLMakeupWidgetState extends State<FTLMakeupWidget> {
  int? _selectedProductIndex;
  int? _selectedColorIndex;
  String? _selectedEyeType;

  final GlobalKey _draggableKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontalPadding,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 30,
                width: 30,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.black.withOpacity(0.24),
                    ),
                  ),
                  icon: Stack(
                    children: [
                      SvgPicture.asset(
                        IconPath.cart,
                        height: 20,
                        width: 20,
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        right: 0,
                        bottom: -2,
                        child: BlocBuilder<ProductCartCubit, ProductCartState>(
                          builder: (context, state) {
                            List<int> products = [];
                            if (state is ProductCartLoaded) {
                              products = state.products;
                            }

                            if (products.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Text(
                                products.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 6,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  onPressed: _onCart,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontalPadding,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.black.withOpacity(0.24),
                      ),
                    ),
                    icon: SvgPicture.asset(
                      IconPath.love,
                      height: 16,
                      width: 16,
                      fit: BoxFit.contain,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Gold Eyeshadow Palette",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Natasha Denona",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontalPadding,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.black.withOpacity(0.24),
                      ),
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  child: Text(
                    "\$129.00",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.horizontalPadding,
                vertical: 10,
              ),
              child: SizedBox(
                width: 80,
                child: Column(
                  children: [
                    const Spacer(),
                    SingleChildScrollView(
                      child: BlocBuilder<ProductCartCubit, ProductCartState>(
                        builder: (context, state) {
                          List<int> products = [];
                          if (state is ProductCartLoaded) {
                            products = state.products;
                          }

                          if (products.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Container(
                            color: Colors.black.withOpacity(0.24),
                            padding: const EdgeInsets.all(8),
                            child: ListView.separated(
                              itemCount: products.length,
                              shrinkWrap: true,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemBuilder: (context, index) {
                                final item = products[index];

                                final isSelected =
                                    item == _selectedProductIndex;

                                return LongPressDraggable<int>(
                                  data: item,
                                  delay: const Duration(milliseconds: 100),
                                  feedback: FractionalTranslation(
                                    translation: const Offset(-0.5, -0.5),
                                    child: ClipRRect(
                                      key: _draggableKey,
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFF858585),
                                          ),
                                        ),
                                        child: Opacity(
                                          opacity: 0.85,
                                          child: Image.asset(
                                            ImagePath.productExample,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _onProductSelected(
                                            item,
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFF858585),
                                            ),
                                          ),
                                          child: Image.asset(
                                            ImagePath.productExample,
                                            height: isSelected ? 60 : 42,
                                            width: isSelected ? 60 : 42,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onDragStarted: () {
                                    if (item != _selectedProductIndex) {
                                      _onProductSelected(
                                        item,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          if (_selectedProductIndex != null) ...[
            Center(
              child: DragTarget<int>(
                builder: (context, candidateData, rejectedData) {
                  final hasItems = candidateData.isNotEmpty;

                  return SvgPicture.asset(
                    IconPath.trash,
                    colorFilter: ColorFilter.mode(
                      hasItems ? Colors.red : Colors.white,
                      BlendMode.srcIn,
                    ),
                  );
                },
                onAcceptWithDetails: (item) {
                  _onDeleteProduct();
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              child: ListView.separated(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 15,
                  );
                },
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  // get opacity from index, example: 1 => 0.1
                  final opacity = (index + 1) / 10;
                  final isSelected = _selectedColorIndex == index;
                  final isFirst = index == 0;
                  final isLast = index == 10 - 1;

                  return Padding(
                    padding: EdgeInsets.only(
                      left: isFirst ? SizeConfig.horizontalPadding : 0,
                      right: isLast ? SizeConfig.horizontalPadding : 0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _onColorSelected(index);
                      },
                      child: Container(
                        height: isSelected ? 40 : 30,
                        width: isSelected ? 40 : 30,
                        decoration: BoxDecoration(
                          color: isFirst
                              ? Colors.transparent
                              : Colors.red.withOpacity(opacity),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected || isFirst
                                ? Colors.white
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: isFirst
                            ? Transform.rotate(
                                angle: -0.7,
                                child: const Divider(
                                  height: 0,
                                ),
                              )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(
              height: 24,
            ),
            SizedBox(
              height: 20,
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListView.separated(
                  itemCount: _eyeTypes.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 15,
                    );
                  },
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    final eyeType = _eyeTypes[index];
                    final isSelected = _selectedEyeType == eyeType;
                    final isFirst = index == 0;
                    final isLast = index == _eyeTypes.length;

                    return Padding(
                      padding: EdgeInsets.only(
                        left: isFirst ? SizeConfig.horizontalPadding : 0,
                        right: isLast ? SizeConfig.horizontalPadding : 0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _onEyeTypeSelected(eyeType);
                        },
                        child: Text(
                          eyeType,
                          style: TextStyle(
                            fontSize: isSelected ? 16 : 14,
                            color: Colors.white.withOpacity(
                              isSelected ? 1 : 0.8,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Divider(
              height: 24,
            ),
            SizedBox(
              height: 50,
              child: ListView.separated(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 17,
                  );
                },
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  final isFirst = index == 0;
                  final isLast = index == 10 - 1;

                  return Container(
                    margin: EdgeInsets.only(
                      left: isFirst ? SizeConfig.horizontalPadding : 0,
                      right: isLast ? SizeConfig.horizontalPadding : 0,
                    ),
                    padding: const EdgeInsets.all(5),
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.asset(
                      ImagePath.eyeStyleExample,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _onCart() {
    widget.onViewAll();
  }

  void _onDeleteProduct() {
    try {
      BlocProvider.of<ProductCartCubit>(context).removeProduct();

      // reset selected product
      setState(() {
        _selectedProductIndex = null;
      });
    } catch (error) {
      sl<ToastInfo>().showToast(
        type: ToastType.error,
        message: error.message,
      );
    }
  }

  void _onProductSelected(int index) {
    if (index == _selectedProductIndex) {
      // un select
      setState(() {
        _selectedProductIndex = null;
      });

      return;
    }

    setState(() {
      _selectedProductIndex = index;
    });
  }

  void _onColorSelected(int index) {
    setState(() {
      _selectedColorIndex = index;
    });
  }

  void _onEyeTypeSelected(String eyeType) {
    setState(() {
      _selectedEyeType = eyeType;
    });
  }
}
