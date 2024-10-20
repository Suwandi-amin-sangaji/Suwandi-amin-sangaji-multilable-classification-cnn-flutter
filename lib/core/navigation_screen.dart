import 'package:flutter/material.dart';
import 'package:hele/core/about/screens/about_navigation_screen.dart';
import 'package:hele/core/constants/icon_constant.dart';
import 'package:hele/core/home/screens/home_navigation_screen.dart';
import 'package:hele/features/article/screens/article_screen.dart';
import 'package:hele/core/constants/color_constant.dart';
import 'package:hele/features/detection/screens/scan_screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;
  late PageController _myPage;

  final List<Widget> _widgetOptions = [
    const HomeNavigationScreen(),
    const AboutNavigationScreen()
  ];

  @override
  void initState() {
    super.initState();
    _myPage = PageController();
  }

  Widget buildNavItem({
    required String icon,
    required int index,
    required double iconSize,
    required EdgeInsetsGeometry margin,
    required double leftTextMargin, // Add a parameter for left text margin
    required double rightTextMargin, // Add a parameter for right text margin
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _myPage.jumpToPage(index);
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Center the content
          children: [
            Container(
              margin: margin,
              child: ImageIcon(
                Svg(icon),
                color: _currentIndex == index
                    ? ColorConstant.primaryColor
                    : Colors.grey,
                size: iconSize,
              ),
            ),
            SizedBox(height: 4), // Adjust the spacing between icon and text
            Container(
              margin: EdgeInsets.only(
                left: leftTextMargin,
                right: rightTextMargin,
              ),
              child: Text(
                index == 0 ? "Home" : "About",
                style: _currentIndex == index
                    ? Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorConstant.primaryColor,
                        )
                    : Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildNavItem(
                icon: IconConstant.homeNavigation,
                index: 0,
                iconSize: 30.0,
                margin: EdgeInsets.only(right: 50.0),
                leftTextMargin: 20.0,
                rightTextMargin: 70.0,
              ),
              buildNavItem(
                icon: IconConstant.aboutAppNavigation,
                index: 1,
                iconSize: 30.0,
                margin: EdgeInsets.only(left: 50.0),
                leftTextMargin: 70,
                rightTextMargin: 20.0,
              ),
            ],
          ),
        ),
      ),
      body: PageView(
          controller: _myPage,
          onPageChanged: ((value) {
            setState(() {
              _currentIndex = value;
            });
          }),
          physics: const NeverScrollableScrollPhysics(),
          children: _widgetOptions),
      floatingActionButton: SizedBox(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            tooltip: "Miner",
            backgroundColor: ColorConstant.primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      ScanScreen(title: "Klasifikasi Penyakit Daun Jagung")));
            },
            child: ImageIcon(
              Svg(
                IconConstant.scan,
              ),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
