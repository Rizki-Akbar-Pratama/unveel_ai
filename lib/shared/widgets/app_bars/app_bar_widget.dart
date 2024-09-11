import 'package:flutter/material.dart';

import '../../configs/size_config.dart';
import '../../extensions/context_parsing.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Color? backgroundColor, iconBackgroundColor;
  final bool? showCloseButton;

  const AppBarWidget({
    super.key,
    this.title,
    this.backgroundColor,
    this.iconBackgroundColor,
    this.showCloseButton = false,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool isFirstRoute = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _init();
  }

  void _init() {
    isFirstRoute = context.isFirstRoute ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: widget.backgroundColor,
      leading: _buildLeading,
      title: _buildTitle,
      actions: [
        _buildCloseButton,
      ],
    );
  }

  Widget? get _buildLeading {
    if (isFirstRoute) {
      return null;
    }

    return Row(
      children: [
        SizedBox(
          width: SizeConfig.horizontalPadding,
        ),
        SizedBox(
          height: 30,
          width: 30,
          child: IconButton(
            padding: EdgeInsets.zero,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                _iconBackgroundColor,
              ),
            ),
            icon: const Icon(
              Icons.chevron_left,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  Color get _iconBackgroundColor {
    if (widget.iconBackgroundColor != null) {
      return widget.iconBackgroundColor!;
    }

    return const Color(0xFFDADADA).withOpacity(0.24);
  }

  Widget? get _buildTitle {
    if (widget.title == null) {
      return null;
    }

    return Text(
      widget.title!,
    );
  }

  Widget get _buildCloseButton {
    if (widget.showCloseButton != true || isFirstRoute) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(
        right: SizeConfig.horizontalPadding,
      ),
      child: SizedBox(
        height: 30,
        width: 30,
        child: IconButton(
          padding: EdgeInsets.zero,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              _iconBackgroundColor,
            ),
          ),
          icon: const Icon(
            Icons.close,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
