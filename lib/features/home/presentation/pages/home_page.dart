import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/configs/route_config.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.horizontalPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              width: context.width,
              text: 'Find the Look',
              onTap: _onFindTheLook,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              width: context.width,
              text: 'Skin Analysis',
              onTap: _onSaLive,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              width: context.width,
              text: 'Skin Tone Finder',
              onTap: _onStfLive,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              width: context.width,
              text: 'Personality Finder',
              onTap: _onPfLive,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              width: context.width,
              text: 'Shop the Look',
              onTap: _onStlLive,
            ),
          ],
        ),
      ),
    );
  }

  void _onFindTheLook() {
    context.goNamed(
      AppRoute.ftlHome.name,
    );
  }

  void _onSaLive() {
    context.goNamed(
      AppRoute.saLive.name,
    );
  }

  void _onStfLive() {
    context.goNamed(
      AppRoute.stfLive.name,
    );
  }

  void _onPfLive() {
    context.goNamed(
      AppRoute.pfLive.name,
    );
  }

  void _onStlLive() {
    context.goNamed(
      AppRoute.stlLive.name,
    );
  }
}
