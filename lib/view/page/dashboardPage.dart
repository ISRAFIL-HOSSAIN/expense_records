import 'package:expense_record/controller/budget_repository.dart';
import 'package:expense_record/utils/exports.dart';
import 'package:expense_record/view/widget/Spending_Pie_Chart.dart';
import 'package:intl/intl.dart';

import '../../model/item_model.dart';
import '../components/category_Color.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<Item>> _futureItems;
  @override
  void initState() {
    super.initState();
    _futureItems = BudgetRepository().getItems();
  }

  @override
  Widget build(BuildContext context) {
    final shight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Expense Records Pie Chart",
          ),

          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 55.2,
          toolbarOpacity: 0.8,
          automaticallyImplyLeading: false,
          titleTextStyle: const TextStyle(
              fontSize: 20,
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
          tooltip: "Add Expense",
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
                    if (index == 0) return SpendPieChart(items: items);

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
}
