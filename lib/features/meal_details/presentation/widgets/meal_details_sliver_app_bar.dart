import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/widgets/arrow_back_icon_button.dart';

class MealDetailsSliverAppBar extends StatelessWidget {
  const MealDetailsSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const ArrowBackIconButton(),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(Assets.iconsHeartIcon),
        ),
      ],
    );
  }
}
