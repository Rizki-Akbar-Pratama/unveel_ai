import 'package:flutter/material.dart';

import '../../../../shared/configs/size_config.dart';
import 'stl_product_item_widget.dart';

class STLProductsListWidget extends StatefulWidget {
  final Function() onAddToCart;

  const STLProductsListWidget({
    super.key,
    required this.onAddToCart,
  });

  @override
  State<STLProductsListWidget> createState() => _STLProductsListWidgetState();
}

class _STLProductsListWidgetState extends State<STLProductsListWidget> {
  int? _selectedColorIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 130,
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
                  left: isFirst ? 14 : 0,
                  right: isEnd ? 14 : 0,
                ),
                child: STLProductItemWidget(
                  onAddToCart: widget.onAddToCart,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onColorSelected(int index) {
    setState(() {
      _selectedColorIndex = index;
    });
  }
}
