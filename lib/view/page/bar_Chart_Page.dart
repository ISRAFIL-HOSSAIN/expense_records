import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../controller/budget_repository.dart';
import '../../model/item_model.dart';
import '../../utils/exports.dart';
import '../widget/Spending_Bar_Chart.dart';

class BarChartPage extends StatefulWidget {
  const BarChartPage({Key? key}) : super(key: key);

  @override
  State<BarChartPage> createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  late Future<List<Item>> _futureItems;
  @override
  void initState() {
    super.initState();
    _futureItems = BudgetRepository().getItems();
  }

  // late double _total;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Bar Chart Expense",
          ),

          centerTitle: true,
          automaticallyImplyLeading: false,
          titleTextStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 255, 254, 252)),

          // backgroundColor: Colors.transparent,
          backgroundColor: AppColors.appBarColor,
          elevation: 0.0,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.logout,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          hoverColor: Colors.orange,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddExpensePage(),
              ),
            );
          },
          label: Row(
            children: const [Icon(Icons.add_circle_sharp), Text('Add')],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _futureItems = BudgetRepository().getItems();
            setState(() {});
          },
          child: FutureBuilder<List<Item>>(
            future: _futureItems,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Show pie chart and list view of items
                final items = snapshot.data!;
                return ListView.builder(
                  itemCount: items.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) return SpendBarChart(items: items);

                    final item = items[index - 1];
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(252, 255, 194, 231),
                            Color.fromARGB(222, 244, 244, 244),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        // border: Border.all(
                        //   width: 2.0,
                        //   // color: getCategoryColor(item.category),
                        // ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(160, 97, 97, 97),
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          item.name,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 61, 77, 221),
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${item.category} . ${DateFormat.yMd().format(item.date)}',
                        ),
                        trailing: Text(
                          '-\$${item.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 2, 14, 129),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                // show failure error message,
                final failure = snapshot.error as Failure;
                return Center(
                  child: Text(failure.message),
                );
              }
              // show a loading spinner
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  // BarChartGroupData makeGroupData(
  //   int x,
  //   double y, {
  //   bool isTouched = false,
  //   Color barColor = Colors.white,
  //   double width = 22,
  //   List<int> showTooltips = const [],
  // }) {
  //   return BarChartGroupData(
  //     x: x,
  //     barRods: [
  //       BarChartRodData(
  //         toY: isTouched ? y + 1 : y,
  //         color: isTouched ? Colors.yellow : barColor,
  //         width: width,
  //         borderSide: isTouched
  //             ? const BorderSide(
  //                 color: Color.fromARGB(255, 0, 120, 218), width: 1)
  //             : const BorderSide(color: Colors.white, width: 0),
  //         backDrawRodData: BackgroundBarChartRodData(
  //           show: true,
  //           toY: 20,
  //           color: barBackgroundColor,
  //         ),
  //       ),
  //     ],
  //     showingTooltipIndicators: showTooltips,
  //   );
  // }

  // List<BarChartGroupData> showingGroups() => List.generate(
  //       7,
  //       (i) {
  //         switch (i) {
  //           case 0:
  //             return makeGroupData(0, 100, isTouched: i == touchedIndex);
  //           case 1:
  //             return makeGroupData(1, 20, isTouched: i == touchedIndex);
  //           case 2:
  //             return makeGroupData(2, 40, isTouched: i == touchedIndex);
  //           case 3:
  //             return makeGroupData(3, 59, isTouched: i == touchedIndex);
  //           case 4:
  //             return makeGroupData(4, 50, isTouched: i == touchedIndex);
  //           case 5:
  //             return makeGroupData(5, 39, isTouched: i == touchedIndex);
  //           case 6:
  //             return makeGroupData(6, 60, isTouched: i == touchedIndex);
  //           default:
  //             return throw Error();
  //         }
  //       },
  //     );
  // BarChartData mainBarData() {
  //   return BarChartData(
  //     barTouchData: BarTouchData(
  //       touchTooltipData: BarTouchTooltipData(
  //           tooltipBgColor: Colors.blueGrey,
  //           getTooltipItem: (group, groupIndex, rod, rodIndex) {
  //             String weekDay;
  //             switch (group.x.toInt()) {
  //               case 0:
  //                 weekDay = 'Monday';
  //                 break;
  //               case 1:
  //                 weekDay = 'Tuesday';
  //                 break;
  //               case 2:
  //                 weekDay = 'Wednesday';
  //                 break;
  //               case 3:
  //                 weekDay = 'Thursday';
  //                 break;
  //               case 4:
  //                 weekDay = 'Friday';
  //                 break;
  //               case 5:
  //                 weekDay = 'Saturday';
  //                 break;
  //               case 6:
  //                 weekDay = 'Sunday';
  //                 break;
  //               default:
  //                 throw Error();
  //             }
  //             return BarTooltipItem(
  //               weekDay + '\n',
  //               const TextStyle(
  //                   color: Color.fromARGB(255, 53, 53, 53),
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 26,
  //                   fontFamily: 'Poppins'),
  //               children: <TextSpan>[
  //                 const TextSpan(
  //                   text: '\$ :5000 ',
  //                   style: TextStyle(
  //                     color: Colors.yellow,
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //               ],
  //             );
  //           }),
  //       touchCallback: (touchEvent, barTouchResponse) {
  //         setState(() {
  //           if (barTouchResponse != null &&
  //               barTouchResponse.spot != null &&
  //               touchEvent.isInterestedForInteractions) {
  //             touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
  //           } else {
  //             touchedIndex = -1;
  //           }
  //         });
  //       },
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       rightTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           getTitlesWidget: getTitles,
  //         ),
  //       ),
  //       topTitles: AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           getTitlesWidget: getTitles,
  //           reservedSize: 30,
  //         ),
  //       ),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: false,
  //         ),
  //       ),
  //     ),
  //     borderData: FlBorderData(
  //       show: false,
  //     ),
  //     barGroups: showingGroups(),
  //     gridData: FlGridData(show: false),
  //   );
  // }

  // Widget getTitles(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     color: Colors.white,
  //     fontWeight: FontWeight.bold,
  //     fontSize: 14,
  //   );
  //   Widget text;
  //   switch (value.toInt()) {
  //     case 0:
  //       text = const Text('M', style: style);
  //       break;
  //     case 1:
  //       text = const Text('T', style: style);
  //       break;
  //     case 2:
  //       text = const Text('W', style: style);
  //       break;
  //     case 3:
  //       text = const Text('T', style: style);
  //       break;
  //     case 4:
  //       text = const Text('F', style: style);
  //       break;
  //     case 5:
  //       text = const Text('St', style: style);
  //       break;
  //     case 6:
  //       text = const Text('Su', style: style);
  //       break;
  //     default:
  //       text = const Text('', style: style);
  //       break;
  //   }
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     space: 16,
  //     child: text,
  //   );
  // }
}
