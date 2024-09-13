import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unveels/features/personality_finder/data/models/recognition.dart';

import '../../../../shared/configs/color_config.dart';
import 'pf_alaysis_details_widget.dart';
import '../../data/models/labels.dart';

class PFPersonalityAnalysisWidget extends StatelessWidget {
  final List<Recognition>? recognition;
  const PFPersonalityAnalysisWidget({super.key, required this.recognition});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  "Main 5 Personality Traits",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _CircularChartBarWidget(
                      height: 140,
                      width: 140,
                      color: ColorConfig.yellow,
                      value: 0.8,
                    ),
                    _CircularChartBarWidget(
                      height: 160,
                      width: 160,
                      color: ColorConfig.pink,
                      value: 0.85,
                    ),
                    _CircularChartBarWidget(
                      height: 180,
                      width: 180,
                      color: ColorConfig.oceanBlue,
                      value: 0.75,
                    ),
                    _CircularChartBarWidget(
                      height: 200,
                      width: 200,
                      color: ColorConfig.green,
                      value: 0.8,
                    ),
                    _CircularChartBarWidget(
                      height: 220,
                      width: 220,
                      color: ColorConfig.purple,
                      value: 0.85,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _LegendItemWidget(
                            color: ColorConfig.yellow,
                            value: (recognition?[0].personalityScore[0]['value'] as double).toInt(),
                            label: Personality[recognition?[0].personalityScore[0]['index']],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          _LegendItemWidget(
                            color: ColorConfig.pink,
                            value: (recognition?[0].personalityScore[1]['value'] as double).toInt(),
                            label: Personality[recognition?[0].personalityScore[1]['index']],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          _LegendItemWidget(
                            color: ColorConfig.oceanBlue,
                            value: (recognition?[0].personalityScore[2]['value'] as double).toInt(),
                            label: Personality[recognition?[0].personalityScore[2]['index']],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          _LegendItemWidget(
                            color: ColorConfig.green,
                            value: (recognition?[0].personalityScore[3]['value'] as double).toInt(),
                            label: Personality[recognition?[0].personalityScore[3]['index']],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                           _LegendItemWidget(
                            color: ColorConfig.purple,
                            value: (recognition?[0].personalityScore[4]['value'] as double).toInt(),
                            label: Personality[recognition?[0].personalityScore[4]['index']],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          PFAnalysisDetailsWidget(
            title: Personality[recognition?[0].personalityScore[0]['index']],
            description:
                Description[recognition?[0].personalityScore[0]['index']],
            score: '${((recognition?[0].personalityScore?[0]?['value'])).toStringAsFixed(1)}%',
          ),
          PFAnalysisDetailsWidget(
            title: Personality[recognition?[0].personalityScore[1]['index']],
            description:
            Description[recognition?[0].personalityScore[1]['index']],
            score: '${((recognition?[0].personalityScore?[1]?['value'])).toStringAsFixed(1)}%',
          ),
          PFAnalysisDetailsWidget(
            title: Personality[recognition?[0].personalityScore[2]['index']],
            description: Description[recognition?[0].personalityScore[2]['index']],
              score: '${((recognition?[0].personalityScore?[2]?['value'])).toStringAsFixed(1)}%',
          ),
          PFAnalysisDetailsWidget(
            title: Personality[recognition?[0].personalityScore[3]['index']],
            description:
            Description[recognition?[0].personalityScore[3]['index']],
              score: '${((recognition?[0].personalityScore?[3]?['value'])).toStringAsFixed(1)}%'
          ),
          PFAnalysisDetailsWidget(
            title: Personality[recognition?[0].personalityScore[4]['index']],
            description:
            Description[recognition?[0].personalityScore[4]['index']],
              score: '${((recognition?[0].personalityScore?[4]?['value'])).toStringAsFixed(1)}%'
          ),
        ],
      ),
    );
  }
}

class _LegendItemWidget extends StatelessWidget {
  final Color color;
  final int value;
  final String label;

  const _LegendItemWidget({
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "$value%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _CircularChartBarWidget extends StatelessWidget {
  final double height, width, value;
  final Color color;

  const _CircularChartBarWidget({
    required this.height,
    required this.width,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Transform.rotate(
        angle: 1.5,
        child: CircularProgressIndicator(
          color: color,
          value: value,
          strokeCap: StrokeCap.round,
          strokeWidth: 6,
        ),
      ),
    );
  }
}
