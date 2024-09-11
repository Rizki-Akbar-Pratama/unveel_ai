import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/configs/asset_path.dart';

class STFProductItemWidget extends StatelessWidget {
  const STFProductItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 115,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            ImagePath.productExample,
            width: 115,
            height: 120 * 0.65,
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
              const SizedBox(
                width: 5,
              ),
              Text(
                "\$15",
                style: GoogleFonts.lora(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.5),
                  textStyle: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.white.withOpacity(0.5),
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
