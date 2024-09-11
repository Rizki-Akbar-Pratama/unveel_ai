import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/asset_path.dart';
import '../buttons/button_widget.dart';

class SmallProductItemWidget extends StatelessWidget {
  final Function()? onAddToCart;

  const SmallProductItemWidget({
    super.key,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 130,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            ImagePath.productExample,
            width: 130,
            height: 130 * 0.65,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "Item name Tom Ford",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lora(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            "Brand name",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lora(
              fontSize: 8,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                "\$15",
                style: GoogleFonts.lora(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 20,
                child: ButtonWidget(
                  text: "Add to cart",
                  backgroundGradient: const LinearGradient(
                    colors: [
                      Color(0xFFCA9C43),
                      Color(0xFF92702D),
                    ],
                  ),
                  style: GoogleFonts.lora(
                    fontSize: 6,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  onTap: onAddToCart,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
