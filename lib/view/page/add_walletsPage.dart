import '../../utils/exports.dart';
import '../components/add_wallets_field.dart';

class AddWalletPage extends StatefulWidget {
  AddWalletPage({Key? key}) : super(key: key);

  @override
  State<AddWalletPage> createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  @override
  Widget build(BuildContext context) {
    String originError = "Email Field can not be empty";
    String bankAccountError = "Password Field Can not be Empty";
    String initialbalanceError = "Password Field Can not be Empty";

    TextEditingController originController = TextEditingController();
    TextEditingController bankAccountController = TextEditingController();
    TextEditingController initialbalanceController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backColor,
        appBar: AppBar(
          title: const Text(
            "Add Wallets Information",
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
              color: Color.fromARGB(232, 243, 243, 243)),
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 240, 239, 239),
            size: 30,
          ),
          // backgroundColor: Colors.transparent,
          backgroundColor: Color.fromARGB(255, 2, 197, 103),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      AddWalletsField(
                        txt: "Origin Name",
                        txt2: "Origin Name",
                        controller: originController,
                        error: originError,
                        icon: const Icon(Icons.account_balance),
                        onUseridValueChange: (value) {
                          print(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddWalletsField(
                        txt: "Bank Account ",
                        txt2: "Account",
                        controller: bankAccountController,
                        error: bankAccountError,
                        icon: const Icon(Icons.credit_card),
                        onUseridValueChange: (value) {
                          print(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AddWalletsField(
                        txt: "Add Balance",
                        txt2: "Add Balance",
                        controller: initialbalanceController,
                        error: initialbalanceError,
                        icon: const Icon(Icons.money),
                        onUseridValueChange: (value) {
                          print(value);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        child:  Button(txt: " + Add ", handleButtonClick:(){
                          addwallet(); 
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
  
  void addwallet() {}
}
