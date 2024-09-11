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
                      const Text(
                        "Extravert",
                        style: TextStyle(
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
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AI Personality Analysis :",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Your face attributes indicate you enjoy interacting with people and are full of energy. Extraversions tend to be enthusiastic, action-oriented, and very social. You're the friendly, inviting individual who likes to talk and connect with people.",
                                style: TextStyle(
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
                  const PFPersonalityAnalysisWidget(),
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
