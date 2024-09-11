import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs/asset_path.dart';
import '../buttons/button_widget.dart';

class ProductItemWidget extends StatelessWidget {
  final double height, width;
  final Function() onAddToCart;
  final Function() onSelect;

  const ProductItemWidget({
    super.key,
    this.height = 300,
    this.width = 195,
    required this.onAddToCart,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            ImagePath.productExample,
            width: width,
            height: width,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Item name Tom Ford",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE6E5E3),
                    ),
                  ),
                  Text(
                    "Brand name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      color: const Color(0xFFE6E5E3).withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                "\$88.00",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFE6E5E3),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          SvgPicture.asset(
            IconPath.fourStarsExample,
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: ButtonWidget(
                    text: "ADD TO CART",
                    backgroundColor: Colors.black,
                    borderColor: Colors.white,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                    onTap: onAddToCart,
                  ),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: ButtonWidget(
                    text: "SELECT",
                    backgroundColor: Colors.white,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                    onTap: onSelect,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
