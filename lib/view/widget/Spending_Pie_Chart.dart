import 'package:expense_record/utils/exports.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/item_model.dart';
import '../components/category_Color.dart';

class SpendPieChart extends StatefulWidget {
  final List<Item> items;

  const SpendPieChart({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<SpendPieChart> createState() => _SpendPieChartState();
}

class _SpendPieChartState extends State<SpendPieChart> {
  @override
  Widget build(BuildContext context) {
    final shight = MediaQuery.of(context).size.height;

    final spending = <String, double>{};

    for (var item in widget.items) {
      spending.update(
        item.category,
        (value) => value + item.amount,
        ifAbsent: () => item.amount,
      );
    }

    return AspectRatio(
      aspectRatio: 0.95,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: shight / 4,
          child: Column(
            children: [
              Expanded(
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(),
                    sections: spending
                        .map(
                          (category, amountSpent) => MapEntry(
                            category,
                            PieChartSectionData(
                              //   final isTouched = category == touchedIndex;
                              // final fontSize = isTouched ? 25.0 : 16.0;
                              // final radius = isTouched ? 60.0 : 50.0;
                              color: getCategoryColor(category),
                              radius: 100.0,
                              title: '\$${amountSpent.toStringAsFixed(2)}',
                              value: amountSpent,
                              titleStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 238, 238, 238),
                              ),
                            ),
                          ),
                        )
                        .values
                        .toList(),
                    sectionsSpace: 0,
                    centerSpaceRadius: 30,
                  ),
                  swapAnimationDuration:
                      const Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                ),
              ),
              const SizedBox(height: 20.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: spending.keys
                    .map((category) => _Indicator(
                          color: getCategoryColor(category),
                          text: category,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final Color color;
  final String text;
  const _Indicator({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 16.0,
          width: 16.0,
          color: color,
        ),
        const SizedBox(width: 8.0),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }
}
