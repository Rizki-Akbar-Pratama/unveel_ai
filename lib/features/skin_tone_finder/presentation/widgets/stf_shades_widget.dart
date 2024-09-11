import 'package:flutter/material.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/tone_tab_parsing.dart';
import 'stf_product_item_widget.dart';

final List<String> _matchedTones = [
  "Cooler",
  "Lighter",
  "Perfect Fit",
  "Warner",
  "Darker",
];

final List<String> _skinTones = [
  "Light tones",
  "Medium tones",
  "Dark Tones",
];

class STFShadesWidget extends StatefulWidget {
  final Function()? onViewAll;

  const STFShadesWidget({
    super.key,
    this.onViewAll,
  });

  @override
  State<STFShadesWidget> createState() => _STFShadesWidgetState();
}

class _STFShadesWidgetState extends State<STFShadesWidget> {
  ToneTab? _selectedToneTab;
  String? _selectedSkinTone;
  String? _selectedMatchedTone;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    _selectedToneTab = ToneTab.values.first;

    _selectedSkinTone = _skinTones.first;

    _selectedMatchedTone = _matchedTones.first;
  }

  @override
  Widget build(BuildContext context) {
    final macthedToneItemWidth = (context.width * 0.9) / _matchedTones.length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _ToneTabItemWidget(
                      tab: ToneTab.values.first,
                      isSelected: _selectedToneTab == ToneTab.values.first,
                      onTap: (value) {
                        if (value != _selectedToneTab) {
                          setState(() {
                            _selectedToneTab = value;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                    child: VerticalDivider(),
                  ),
                  Expanded(
                    child: _ToneTabItemWidget(
                      tab: ToneTab.values.last,
                      isSelected: _selectedToneTab == ToneTab.values.last,
                      onTap: (value) {
                        if (value != _selectedToneTab) {
                          setState(() {
                            _selectedToneTab = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 30,
          child: ListView.separated(
            itemCount: _skinTones.length,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 10,
              );
            },
            itemBuilder: (context, index) {
              final skinTone = _skinTones[index];
              final isSelected = skinTone == _selectedSkinTone;
              final isFirst = index == 0;
              final isEnd = index == _skinTones.length - 1;
              // get opacity from index, example: 1 => 0.1
              final opacity = (1 - index / 10);

              return Padding(
                padding: EdgeInsets.only(
                  left: isFirst ? SizeConfig.horizontalPadding : 0,
                  right: isEnd ? SizeConfig.horizontalPadding : 0,
                ),
                child: _SkinToneItemWidget(
                  title: skinTone,
                  color: const Color(0xFF8F4F36).withOpacity(
                    opacity,
                  ),
                  isSelected: isSelected,
                  onTap: (value) {
                    if (value != _selectedSkinTone) {
                      setState(() {
                        _selectedSkinTone = value;
                      });
                    }
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 13,
        ),
        Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: _matchedTones.map((matchedTone) {
            final isSelected = matchedTone == _selectedMatchedTone;
            // get opacity from index, example: 1 => 0.9
            final opacity = (1 - _matchedTones.indexOf(matchedTone) / 10);

            return _MatchedToneItemWidget(
              title: matchedTone,
              color: const Color(0xFFCB8B5E).withOpacity(
                opacity,
              ),
              isSelected: isSelected,
              width: macthedToneItemWidth,
              onTap: (value) {
                if (value != _selectedMatchedTone) {
                  setState(() {
                    _selectedMatchedTone = value;
                  });
                }
              },
            );
          }).toList(),
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
                  left: isFirst ? SizeConfig.horizontalPadding : 0,
                  right: isEnd ? SizeConfig.horizontalPadding : 0,
                ),
                child: const STFProductItemWidget(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ToneTabItemWidget extends StatelessWidget {
  final ToneTab tab;
  final bool isSelected;
  final Function(ToneTab value) onTap;

  const _ToneTabItemWidget({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(tab);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
        ),
        child: Center(
          child: Text(
            tab.title,
            style: TextStyle(
              fontSize: 18,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkinToneItemWidget extends StatelessWidget {
  final String title;
  final Color color;
  final bool isSelected;
  final Function(String value) onTap;

  const _SkinToneItemWidget({
    required this.title,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(title);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.white : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 1,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchedToneItemWidget extends StatelessWidget {
  final String title;
  final Color color;
  final bool isSelected;
  final Function(String value) onTap;
  final double width;

  const _MatchedToneItemWidget({
    required this.title,
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(title);
      },
      child: Container(
        height: isSelected ? 40 : 26,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
