import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:voyage/utils/constants.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

final _controller = PageController(
  initialPage: 0,
);

int _currentPage = 0;

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  Widget page(String image, String description) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            image,
            width: MediaQuery.of(context).size.shortestSide / 1.25,
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      page("assets/images/ob_board1.png", "Set your delivery location"),
      page("assets/images/on_board2.png",
          "Order online from your favourite store"),
      page("assets/images/on_board3.png", "Quick delivery to your doorstep"),
    ];

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: pages,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          height20,
          DotsIndicator(
            dotsCount: pages.length,
            position: _currentPage.toDouble(),
            decorator: const DotsDecorator(
              color: Colors.grey, // Inactive color
              activeColor: AppColors.charcoal,
            ),
          ),
          height20,
        ],
      ),
    );
  }
}
