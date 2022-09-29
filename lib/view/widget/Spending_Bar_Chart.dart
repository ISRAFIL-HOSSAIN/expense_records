import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/item_model.dart';
import '../../utils/appColors.dart';

class SpendBarChart extends StatefulWidget {
  final List<Item> items;
  const SpendBarChart({
    Key? key,
    required this.items,
  }) : super(key: key);

  // SpendBarChart({List<Item> }) : items = transaction;
  @override
  State<StatefulWidget> createState() => SpendBarChartState();
}

class SpendBarChartState extends State<SpendBarChart> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;
  late double _total;
  List<double> _spendings = List.generate(7, (index) => 0);

  double _calculateTotal() {
    if (_spendings.isNotEmpty) {
      _spendings.clear();
      _spendings = List.generate(7, (index) => 0);
    }
    if (widget.items.isEmpty) {
      return 0;
    }

    double sum = 0;
    for (var item in widget.items) {
      _spendings[item.date.weekday - 1] += item.amount;
      sum += item.amount;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final shight = MediaQuery.of(context).size.height;

    _calculateTotal();

    // final spending = <String, double>{};
    // for (var item in widget.items) {
    //   spending.update(
    //     item.category,
    //     (value) => value + item.amount,
    //     ifAbsent: () => item.amount,
    //   );
    // }
    _total = _spendings.reduce(max);
    return Container(
      margin: const EdgeInsets.all(10),
      height: shight / 2.5,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: AppColors.barcolor,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Text(
                    'Weekly Expenses',
                    style: TextStyle(
                      color: Color.fromARGB(230, 240, 255, 252),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Bar Chart',
                    style: TextStyle(
                        color: Color.fromARGB(155, 216, 242, 236),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          borderSide: isTouched
              ? const BorderSide(
                  color: Color.fromARGB(255, 0, 120, 218), width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: _total,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, _spendings[0],
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, _spendings[1],
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, _spendings[2],
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, _spendings[3],
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, _spendings[4],
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, _spendings[5],
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, _spendings[6],
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Color.fromARGB(255, 1, 44, 65),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                    color: Color.fromARGB(255, 208, 208, 208),
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    fontFamily: 'Poppins'),
                children: <TextSpan>[
                  TextSpan(
                    text: '\$  ${rod.toY - 1}',
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (touchEvent, barTouchResponse) {
          setState(() {
            if (barTouchResponse != null &&
                barTouchResponse.spot != null &&
                touchEvent.isInterestedForInteractions) {
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 30,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('St', style: style);
        break;
      case 6:
        text = const Text('Su', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
