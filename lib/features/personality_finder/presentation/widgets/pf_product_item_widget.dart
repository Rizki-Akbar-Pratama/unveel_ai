import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';

class PFProductItemWidget extends StatelessWidget {
  const PFProductItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 242,
      width: 151,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            ImagePath.productExample,
            height: 242 * 0.65,
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
                    const Text(
                      "Item name Tom Ford",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Brand name",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "\$15",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ButtonWidget(
                  text: "ADD TO CART",
                  backgroundColor: Colors.transparent,
                  borderColor: Colors.white,
                  height: 27,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: ButtonWidget(
                  text: "SEE\nIMPROVEMENT",
                  backgroundColor: Colors.white,
                  height: 27,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 0,
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
