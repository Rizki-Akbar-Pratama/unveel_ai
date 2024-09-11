import 'package:flutter/material.dart';

import '../../../../shared/configs/size_config.dart';
import 'pf_product_item_widget.dart';

class PfRecommendationsAnalysisWidget extends StatelessWidget {
  const PfRecommendationsAnalysisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductItemWidget(
            title: "Perfumes Recommendations",
          ),
          SizedBox(
            height: 30,
          ),
          _ProductItemWidget(
            title: "Look Recommendations",
            description:
                "A bold red lipstick and defined brows, mirror your strong, vibrant personality",
          ),
          SizedBox(
            height: 30,
          ),
          _ProductItemWidget(
            title: "Lip Color Recommendations",
            description: "The best lip color for you are orange shades",
          ),
          SizedBox(
            height: 30,
          ),
          _ProductItemWidget(
            title: "Accessories Recommendations",
          ),
        ],
      ),
    );
  }
}

class _ProductItemWidget extends StatelessWidget {
  final String title;
  final String? description;

  const _ProductItemWidget({
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (description != null) ...[
                const SizedBox(
                  height: 6,
                ),
                Text(
                  description!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 242,
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
                child: const PFProductItemWidget(),
              );
            },
          ),
        ),
      ],
    );
  }
}
