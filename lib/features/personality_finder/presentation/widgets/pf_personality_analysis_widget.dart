import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/configs/color_config.dart';
import 'pf_alaysis_details_widget.dart';

class PFPersonalityAnalysisWidget extends StatelessWidget {
  const PFPersonalityAnalysisWidget({super.key});

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
                            color: ColorConfig.yellow,
                            value: 95,
                            label: "Extraversion",
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _LegendItemWidget(
                            color: ColorConfig.pink,
                            value: 25,
                            label: "Conscientiousness",
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _LegendItemWidget(
                            color: ColorConfig.oceanBlue,
                            value: 66,
                            label: "Openness to Experience",
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
                            color: ColorConfig.green,
                            value: 80,
                            label: "Agreeableness",
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _LegendItemWidget(
                            color: ColorConfig.purple,
                            value: 40,
                            label: "Neuroticism",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const PFAnalysisDetailsWidget(
            title: "Openness",
            description:
                "People with an open personality are known for their vibrant imagination, curiosity, and eagerness to explore new ideas and experiences. You have a strong desire for novelty and diversity, and you're open to different perspectives and ways of thinking. With the trait of openness, you tend to be creative, flexible, and adaptable and are often receptive to change and innovation.\nYou're obsessed with discovering new cultures, concepts, and opportunities, and are willing to challenge conventional norms and beliefs. Overall, those with an open personality bring a sense of wonder and enthusiasm to their interactions and endeavours. Thus, here is your recommendation list from Unveels based on having an Open Personality",
          ),
          const PFAnalysisDetailsWidget(
            title: "Neuroticism",
            description:
                "Neuroticism , as a personality trait, reflects an individual's tendency to experience negative emotions such as anxiety, depression, and moodiness. People high in neuroticism may be more prone to worry, stress, and self-doubt, they often react strongly to perceived threats or challenges. Those low in neuroticism, on the other hand, tend to be more emotionally stable and resilient in the face of adversity. Thus, here's your bespoke recommendation list from Unveels based on your Neuroticism.",
          ),
          const PFAnalysisDetailsWidget(
            title: "Agreeableness",
            description:
                "People with an Agreeable personality reveal their kind-hearted and compassionate nature; characterized by a strong desire to maintain harmonious relationships.\nPeople, high in agreeableness, are often cooperative, empathetic, and considerate towards others; making them valuable team players and supportive friends.\nThey prioritize the needs of others and are willing to go out of their way to help and support those around them. Their warm and nurturing behaviour makes them approachable and easy to get along with, fostering a sense of trust and camaraderie in their social interactions.\n\nIn short, your agreeable personality is a key aspect of your character and it influences your interactions and relationships with others.\nUnveels has prepared a customized recommendation list based on your agreeable personality.",
          ),
          const PFAnalysisDetailsWidget(
            title: "Extraversion",
            description:
                "An extravert personality provides insights into an individual's social behaviour and interaction preferences.\nExtraverts are known for their outgoing, energetic, and talkative nature. They thrive in social settings, seek excitement, and enjoy being the center of attention. Extraverts are often described as sociable, assertive, and enthusiastic individuals who are comfortable in group settings and have a wide circle of friends.\nThis also delves into the extraversion traits; highlighting that they're strong in communication, leadership, and relationship-building skills.\nTherefore, here's what Unveels suggests for you based on your Extraversion.",
          ),
          const PFAnalysisDetailsWidget(
            title: "Conscientiousness",
            description:
                "Conscientiousness is a key personality trait that reflects an individual's tendency to be organized, responsible, and goal-oriented. People high in conscientiousness are known for their reliability, diligence, and attention to detail; moreover, they're often diligent in their work, follow through on tasks, and are typically well-prepared.\n\nUnveels has unveiled the Conscientious side of your personality; and here's your recommended list based on it.",
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
