import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import 'sa_alaysis_details_widget.dart';

class SAFullAnalysisResultsWidget extends StatefulWidget {
  const SAFullAnalysisResultsWidget({super.key});

  @override
  State<SAFullAnalysisResultsWidget> createState() =>
      _SAFullAnalysisResultsWidgetState();
}

class _SAFullAnalysisResultsWidgetState
    extends State<SAFullAnalysisResultsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        child: BottomCopyrightWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.horizontalPadding,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Analysis Results",
                      style: TextStyle(
                        color: ColorConfig.primary,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          ImagePath.saFaceExample,
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _SummaryItemWidget(
                                iconPath: IconPath.connectionChart,
                                value: "Skin Health Score : 72%",
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              _SummaryItemWidget(
                                iconPath: IconPath.hasTagCircle,
                                value: "Skin Age: 27",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Detected Skin Problems",
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
                          SizedBox(
                            height: 130,
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "80%",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 21,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Skin Problems",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _CircularChartBarWidget(
                            height: 140,
                            width: 140,
                            color: ColorConfig.green,
                            value: 0.8,
                          ),
                          _CircularChartBarWidget(
                            height: 160,
                            width: 160,
                            color: ColorConfig.purple,
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
                            color: ColorConfig.blue,
                            value: 0.8,
                          ),
                          _CircularChartBarWidget(
                            height: 220,
                            width: 220,
                            color: ColorConfig.yellow,
                            value: 0.85,
                          ),
                          _CircularChartBarWidget(
                            height: 240,
                            width: 240,
                            color: ColorConfig.taffi,
                            value: 0.75,
                          ),
                          _CircularChartBarWidget(
                            height: 260,
                            width: 260,
                            color: ColorConfig.pink,
                            value: 0.9,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                _LegendItemWidget(
                                  color: ColorConfig.green,
                                  value: 95,
                                  label: "Texture",
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.purple,
                                  value: 25,
                                  label: "Dark Circles",
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.oceanBlue,
                                  value: 66,
                                  label: "Eyebags",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                _LegendItemWidget(
                                  color: ColorConfig.blue,
                                  value: 80,
                                  label: "Wrinkles",
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.yellow,
                                  value: 40,
                                  label: "Pores",
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.taffi,
                                  value: 10,
                                  label: "Spots",
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.pink,
                                  value: 99,
                                  label: "Acne",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        "Detected Skin Condition",
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
                          SizedBox(
                            height: 130,
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "80%",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 21,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Skin Condition",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _CircularChartBarWidget(
                            height: 140,
                            width: 140,
                            color: ColorConfig.green,
                            value: 0.8,
                          ),
                          _CircularChartBarWidget(
                            height: 160,
                            width: 160,
                            color: ColorConfig.purple,
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
                            color: ColorConfig.blue,
                            value: 0.8,
                          ),
                          _CircularChartBarWidget(
                            height: 220,
                            width: 220,
                            color: ColorConfig.yellow,
                            value: 0.85,
                          ),
                          _CircularChartBarWidget(
                            height: 240,
                            width: 240,
                            color: ColorConfig.taffi,
                            value: 0.75,
                          ),
                          _CircularChartBarWidget(
                            height: 260,
                            width: 260,
                            color: ColorConfig.pink,
                            value: 0.9,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                _LegendItemWidget(
                                  color: ColorConfig.green,
                                  value: 95,
                                  label: "Firmness",
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.purple,
                                  value: 25,
                                  label: "Droopy Upper Eyelid",
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.oceanBlue,
                                  value: 66,
                                  label: "Droopy Lower Eyelid",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                _LegendItemWidget(
                                  color: ColorConfig.blue,
                                  value: 80,
                                  label: "Moisture Level",
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.yellow,
                                  value: 40,
                                  label: "Oiliness",
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.taffi,
                                  value: 10,
                                  label: "Redness",
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _LegendItemWidget(
                                  color: ColorConfig.pink,
                                  value: 99,
                                  label: "Radiance",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SAAnalysisDetailsWidget(
                title: "Spots",
              ),
              const SAAnalysisDetailsWidget(
                title: "Texture",
              ),
              const SAAnalysisDetailsWidget(
                title: "Dark Circles",
              ),
              const SAAnalysisDetailsWidget(
                title: "Redness",
              ),
              const SAAnalysisDetailsWidget(
                title: "Oiliness",
              ),
              const SAAnalysisDetailsWidget(
                title: "Moisture",
              ),
              const SAAnalysisDetailsWidget(
                title: "Pores",
              ),
              const SAAnalysisDetailsWidget(
                title: "Eye Bags",
              ),
              const SAAnalysisDetailsWidget(
                title: "Radiance",
              ),
              const SAAnalysisDetailsWidget(
                title: "Firmness",
              ),
              const SAAnalysisDetailsWidget(
                title: "Droopy Upper Eyelid",
              ),
              const SAAnalysisDetailsWidget(
                title: "Droopy Lower Eyelid",
              ),
              const SAAnalysisDetailsWidget(
                title: "Acne",
              ),
            ],
          ),
        ),
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

class _SummaryItemWidget extends StatelessWidget {
  final String iconPath;
  final String value;

  const _SummaryItemWidget({
    required this.iconPath,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
