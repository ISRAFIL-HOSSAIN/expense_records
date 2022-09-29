import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/exports.dart';
import '../components/add_Expense_field.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _expenseoriginController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _expenseCategoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late DateTime _pickedDate;

  void _startDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.parse("2020-01-01 00:00:01Z"),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      _pickedDate = value;
      _dateController.text = DateFormat.yMMMd().format(_pickedDate);
    });
  }

  String resourceError = "Email Field can not be empty";
  String amountError = "Password Field Can not be Empty";
  String dateError = "Password Field Can not be Empty";
  String categoryError = "Password Field Can not be Empty";
  String billingError = "";
  
  TextEditingController imageController = TextEditingController();
  TextEditingController resourceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController billingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backColor,
        appBar: AppBar(
          title: const Text(
            "Add Expense Record ",
          ),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 253, 252, 255)),
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 240, 239, 239),
            size: 30,
          ),
          // backgroundColor: Colors.transparent,
          backgroundColor:const Color.fromARGB(255, 2, 197, 103),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(
                              'images/illustration-2.png',
                            ),
                            radius: 80,
                          ),
                          Positioned(
                            bottom: 0,
                            child: InkWell(
                              child: const Icon(Icons.camera),
                              onTap: () {
                                print("Camera clicked ");
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddExpenseField(
                        txt: "Expense Origin",
                        txt2: "Expense Origin",
                        controller: resourceController,
                        error: resourceError,
                        icon: const Icon(Icons.trip_origin),
                        onUseridValueChange: (value) {
                          print(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddExpenseField(
                        txt: "Amount",
                        txt2: "Amount",
                        controller: amountController,
                        error: amountError,
                        icon: const Icon(Icons.money),
                        onUseridValueChange: (value) {
                          print(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddExpenseField(
                        txt: "Date",
                        txt2: "Date",
                        controller: dateController,
                        error: dateError,
                        icon: const Icon(Icons.date_range),
                        onUseridValueChange: (value) {
                          print(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddExpenseField(
                        txt: "Expense Category",
                        txt2: "Category",
                        controller: categoryController,
                        error: categoryError,
                        icon: const Icon(Icons.category),
                        onUseridValueChange: (value) {
                          print(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddExpenseField(
                        txt: "Billing",
                        txt2: "Billing",
                        controller: billingController,
                        error: billingError,
                        icon: const Icon(Icons.note),
                        onUseridValueChange: (value) {
                          print(value);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        child:  Button(txt: " + Add ",  handleButtonClick:(){
                          addexpense(); 
                        }),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const VerificationScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
  
  void addexpense() {}
}
