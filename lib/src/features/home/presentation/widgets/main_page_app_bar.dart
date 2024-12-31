import 'package:celebrare/src/core/constants/colors.dart';
import 'package:celebrare/src/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          // close app
          SystemNavigator.pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColor.gray,
          size: 25,
        ),
      ),
      title: Text(
        'Add Image / Icon',
        style: AppTextStyles.loraFont20Gray100ItalicRegular1,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColor.shadeTeal,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
