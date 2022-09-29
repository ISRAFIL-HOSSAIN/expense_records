import 'package:expense_record/view/page/add_walletsPage.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../controller/budget_repository.dart';
import '../../model/item_model.dart';
import '../../utils/exports.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            "Wallets Information",
          ),

          centerTitle: true,
          automaticallyImplyLeading: false,
          titleTextStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
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
                builder: (context) => AddWalletPage(),
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
                    if (index == 0) {
                      return Container(
                          padding: const EdgeInsets.all(25),
                          margin: const EdgeInsets.all(20),
                          height: shight / 3.5,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromARGB(237, 66, 85, 157),
                                AppColors.barcolor,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(66, 24, 24, 24),
                                offset: Offset(0, 2),
                                blurRadius: 8.0,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Source : Jamuna Bank ",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(223, 239, 236, 250),
                                ),
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Bank Account : 3434343438943043434",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.wcolor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ]),
                              const Text(
                                "Initial Balance  : \$ 500 ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.wcolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "Total Expense : \$ 200",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.wcolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "Balance Remaining: \$ 300",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.wcolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ));
                    }

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
