import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import 'sa_product_item_widget.dart';

final _categories = [
  "Wrinkles",
  "Spots",
  "Texture",
  "Dark circles",
  "Redness",
  "Oiliness",
  "Moisture",
];

class SAAnalysisResultsWidget extends StatefulWidget {
  final Function() onViewAll;

  const SAAnalysisResultsWidget({
    super.key,
    required this.onViewAll,
  });

  @override
  State<SAAnalysisResultsWidget> createState() =>
      _SAAnalysisResultsWidgetState();
}

class _SAAnalysisResultsWidgetState extends State<SAAnalysisResultsWidget> {
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
          height: 55,
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
                  left: isFirst ? 8 : 0,
                  right: isEnd ? 8 : 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isSelected) ...[
                      const Text(
                        "60%",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                    ButtonWidget(
                      text: category,
                      backgroundColor: isSelected ? null : Colors.transparent,
                      borderColor: Colors.white,
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      borderRadius: BorderRadius.circular(99),
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding * 1.9,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              ReadMoreText(
                "Hey there! As much as we embrace aging gracefully, those detected creases and lines can sneak up on us sooner than we'd like. To fend off those pesky wrinkles, remember to stay hydrated and wear sunscreen daily. Adding a skin-nourishing routine can work wonders. Embrace your lines, but there's no harm in giving them a little extra tender loving care by checking our recommendations to keep them at bay for as long as possible. Your future self will thank you and us for the care!.",
                trimMode: TrimMode.Line,
                trimLines: 3,
                colorClickableText: ColorConfig.primary,
                trimCollapsedText: 'More',
                trimExpandedText: 'Less',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                moreStyle: TextStyle(
                  fontSize: 14,
                  color: ColorConfig.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: widget.onViewAll,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: SizeConfig.horizontalPadding,
              ),
              child: const Text(
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
                  left: isFirst ? 8 : 0,
                  right: isEnd ? 8 : 0,
                ),
                child: const SAProductItemWidget(),
              );
            },
          ),
        ),
      ],
    );
  }
}
