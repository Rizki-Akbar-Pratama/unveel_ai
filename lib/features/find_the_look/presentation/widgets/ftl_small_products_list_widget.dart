import 'package:flutter/material.dart';

import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/products/small_product_item_widget.dart';

final _categories = [
  "Lipstick",
  "Eyeliner",
  "Eyeshadow",
  "Blush",
  "Foundation",
  "Mascara",
  "Highlighter",
];

class FTLSmallProductsListWidget extends StatefulWidget {
  final Function() onViewAll;

  const FTLSmallProductsListWidget({
    super.key,
    required this.onViewAll,
  });

  @override
  State<FTLSmallProductsListWidget> createState() =>
      _FTLSmallProductsListWidgetState();
}

class _FTLSmallProductsListWidgetState
    extends State<FTLSmallProductsListWidget> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    _selectedCategory = _categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 30,
          child: ListView.separated(
            itemCount: _categories.length,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 15,
              );
            },
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category;
              final isFirst = index == 0;
              final isEnd = index == _categories.length - 1;

              return Padding(
                padding: EdgeInsets.only(
                  left: isFirst ? 14 : 0,
                  right: isEnd ? 14 : 0,
                ),
                child: ButtonWidget(
                  text: category,
                  backgroundColor: isSelected ? null : Colors.transparent,
                  borderColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  borderRadius: BorderRadius.circular(99),
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: widget.onViewAll,
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
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
                child: const SmallProductItemWidget(),
              );
            },
          ),
        ),
      ],
    );
  }
}
