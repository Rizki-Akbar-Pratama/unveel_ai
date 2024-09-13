import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unveels/features/personality_finder/data/models/recognition.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/pf_tab_bar_parsing.dart';
import '../../data/models/labels.dart';
import 'pf_attributes_analysis_widget.dart';
import 'pf_personality_analysis_widget.dart';
import 'pf_recommendations_analysis_widget.dart';

class PFAnalysisResultsWidget extends StatefulWidget {
  final List<Recognition>? recognition;
  final XFile? profile;

  const PFAnalysisResultsWidget({super.key, required this.recognition, required this.profile});

  @override
  State<PFAnalysisResultsWidget> createState() =>
      _PFAnalysisResultsWidgetState();
}

class _PFAnalysisResultsWidgetState extends State<PFAnalysisResultsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 30, // padding to recording controller buttons
      ),
      color: Colors.black,
      child: DefaultTabController(
        length: PFTabBar.values.length,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.horizontalPadding,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      ClipOval(child:
                      Image.file(
                        File(widget.profile!.path),
                        width: 108,
                        height: 108,
                      ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.recognition != null && widget.recognition!.isNotEmpty
                            ? widget.recognition![0].personality ?? "Unknown Personality"
                            : "No Prediction",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          IconPath.hasTagCircle,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded( // Hapus 'const' di sini
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text( // Tambahkan 'const' di sini jika teksnya statis
                                "AI Personality Analysis :",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                Personality_Analysis[widget.recognition?[0].personalityScore?[0]?['index'] ?? 0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
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
            const SizedBox(
              height: 20,
            ),
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: const Color(0xFF9E9E9E),
              labelColor: ColorConfig.primary,
              indicatorColor: ColorConfig.primary,
              labelStyle: const TextStyle(
                fontSize: 16,
              ),
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              dividerColor: const Color(0xFF9E9E9E),
              dividerHeight: 1.5,
              tabs: PFTabBar.values.map((e) {
                return Tab(
                  text: e.title,
                );
              }).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PFPersonalityAnalysisWidget(recognition: widget.recognition,),
                  PFAttributesAnalysisWidget(recognition: widget.recognition,),
                  const PfRecommendationsAnalysisWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
