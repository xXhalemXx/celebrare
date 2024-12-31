import 'package:celebrare/src/features/home/presentation/widgets/select_image.dart';
import 'package:celebrare/src/features/home/presentation/widgets/main_page_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainPageAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SelectImage(),
          ),
          Expanded(
            flex: 5,
            child: SizedBox(),
          )
        ],
      ),
    );
  }
}
