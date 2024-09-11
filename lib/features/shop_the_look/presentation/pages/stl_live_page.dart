import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../../../../shared/widgets/lives/live_widget.dart';
import '../../../find_the_look/presentation/pages/ftl_live_page.dart';
import '../cubit/product_cart/product_cart_cubit.dart';
import '../widgets/stl_makeup_widget.dart';
import '../widgets/stl_products_list_widget.dart';

class STLLivePage extends StatelessWidget {
  const STLLivePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCartCubit(),
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  late LiveStep step;

  bool _isHideTryThisLookButton = false;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    // default step
    step = LiveStep.scannedFace;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiveWidget(
        liveStep: step,
        liveType: LiveType.liveCamera,
        body: _buildBody,
        onLiveStepChanged: (value) {
          if (value != step) {
            if (mounted) {
              setState(() {
                step = value;
              });
            }
          }
        },
      ),
    );
  }

  Widget get _buildBody {
    switch (step) {
      case LiveStep.photoSettings:
        return const SizedBox.shrink();
      case LiveStep.scanningFace:
        return const SizedBox.shrink();
      case LiveStep.scannedFace:
        if (_isHideTryThisLookButton) {
          return const BottomCopyrightWidget(
            child: SizedBox.shrink(),
          );
        }

        return BottomCopyrightWidget(
          child: Column(
            children: [
              ButtonWidget(
                text: 'TRY THIS LOOK',
                width: context.width / 2,
                backgroundColor: Colors.black,
                onTap: _onProductsList,
              ),
            ],
          ),
        );
      case LiveStep.makeup:
        return BottomCopyrightWidget(
          child: STLMakeupWidget(
            onProductsList: _onProductsList,
          ),
        );
    }
  }

  Future<void> _onProductsList() async {
    // hide products list
    setState(() {
      _isHideTryThisLookButton = true;
    });

    // show bottom sheet
    await showModalBottomSheet<bool?>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: SizeConfig.bottomLiveMargin,
          ),
          child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                STLProductsListWidget(
                  onAddToCart: onAddToCart,
                ),
              ],
            ),
          ),
        );
      },
    );

    final productCartState = BlocProvider.of<ProductCartCubit>(context).state;
    if (productCartState is ProductCartLoaded) {
      final products = productCartState.products;
      if (products.isNotEmpty) {
        // set step to makeup
        setState(() {
          step = LiveStep.makeup;
        });

        return;
      }
    }

    // unhide try this look button
    setState(() {
      _isHideTryThisLookButton = false;
    });
  }

  void onAddToCart() {
    BlocProvider.of<ProductCartCubit>(context).addProduct();
  }
}
