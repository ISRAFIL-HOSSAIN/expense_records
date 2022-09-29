import 'package:expense_record/utils/exports.dart';

class Item {
  final String name;
  final String category;
  final String billing;
  final double amount;
  final DateTime date;

  const Item({
    required this.name,
    required this.category,
    required this.billing,
    required this.amount,
    required this.date,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    final properties = map['properties'] as Map<String, dynamic>;
    final dateStr = properties['Date']?['date']?['start'];

    return Item(
      name: properties['Name']?['title']?[0]?['plain_text'] ?? '?',
      category: properties['Category']?['select']?['name'] ?? 'Any',
      amount: (properties['amount']?['number'] ?? 0).toDouble(),
      date: dateStr != null ? DateTime.parse(dateStr) : DateTime.now(),

      // createdOn: DateTime.fromMillisecondsSinceEpoch(map['createdOn']),
      billing: properties['Billing']?['rich_text']?[0]?['plain_text'] ?? '?',
    );
  }
}
