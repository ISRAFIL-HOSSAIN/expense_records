import 'package:expense_record/utils/exports.dart';

class BItem {
  final String name;
  final String category;
  final String billing;
  final double amount;
  final DateTime date;
  final DateTime createdOn;

  const BItem({
    required this.name,
    required this.category,
    required this.billing,
    required this.amount,
    required this.date,
    required this.createdOn,
  });

  factory BItem.fromMap(Map<String, dynamic> map) {
    final properties = map['properties'] as Map<String, dynamic>;
    final dateStr = properties['Date']?['date']?['start'];
    final time = properties['Date']?['date']?['end'];
    return BItem(
      name: properties['Name']?['title']?[0]?['plain_text'] ?? '?',
      category: properties['Category']?['select']?['name'] ?? 'Any',
      amount: (properties['amount']?['number'] ?? 0).toDouble(),
      date: dateStr != null ? DateTime.parse(dateStr) : DateTime.now(),
      createdOn: time != null ? DateTime.parse(time) : DateTime.now(),
      // createdOn: DateTime.fromMillisecondsSinceEpoch(map['createdOn']),
      billing: properties['Billing']?['rich_text']?[0]?['plain_text'] ?? '?',
    );
  }
}
