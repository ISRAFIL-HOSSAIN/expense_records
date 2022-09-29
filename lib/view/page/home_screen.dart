import 'package:expense_record/view/page/bar_Chart_Page.dart';

import '../../utils/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();

  int maxCount = 3;
  int sized = 26;

  // widget list
  final List<Widget> bottomBarPages = [
    const DashboardPage(),
    BarChartPage(),
    const ProfilePage(),
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: Colors.white,
              showLabel: false,
              bottomBarItems: const [
                BottomBarItems(
                  inActiveItem: Icon(
                    Icons.dashboard,
                    color: Colors.blueGrey,
                    size: 26,
                  ),
                  activeItem: Icon(
                    Icons.dashboard,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'DashboardPage',
                ),
                BottomBarItems(
                  inActiveItem: Icon(
                    Icons.bar_chart,
                    color: Colors.blueGrey,
                    size: 30,
                  ),
                  activeItem: Icon(
                    Icons.bar_chart,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'BarChartPage',
                ),
                BottomBarItems(
                  inActiveItem: Icon(
                    Icons.wallet,
                    color: Colors.blueGrey,
                    size: 30,
                  ),
                  activeItem: Icon(
                    Icons.wallet,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'ProfilePage',
                ),
              ],
              onTap: (index) {
                // Control animation using page controller
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeIn);
              },
            )
          : null,
    ));
  }
}
