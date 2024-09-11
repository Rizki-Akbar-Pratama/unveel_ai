import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';

class SAProductItemWidget extends StatelessWidget {
  const SAProductItemWidget({
    super.key,
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
              ),
              Text(
                "\$15",
                style: GoogleFonts.lora(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ButtonWidget(
                  text: "ADD TO CART",
                  backgroundColor: Colors.transparent,
                  borderColor: Colors.white,
                  height: 20,
                  style: GoogleFonts.lora(
                    fontSize: 6,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: ButtonWidget(
                  text: "SEE\nIMPROVEMENT",
                  backgroundColor: Colors.white,
                  height: 20,
                  style: GoogleFonts.lora(
                    fontSize: 6,
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
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
