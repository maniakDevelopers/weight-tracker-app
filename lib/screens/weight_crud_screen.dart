import 'dart:convert';

import 'package:weight_tracker_app/common/packages.dart';
import 'package:http/http.dart' as http;

// Save, Edit and Delete Weight

class WeightCrudScreen extends StatefulWidget {
  WeightCrudScreen({super.key, required this.title});

  final String title;

  @override
  State<WeightCrudScreen> createState() => _WeightCrudScreenState();
}

class _WeightCrudScreenState extends State<WeightCrudScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String? userid;
  String? weight;
  String? weighed_on;
  String userId = "test";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken =
        JwtDecoder.decode(context.read<TokenProvider>().token!);
    userId = jwtDecodedToken["id"];
  }

  final TextEditingController _weightController = TextEditingController();
  bool _validate = false;
  void addWeight() async {
    if (_weightController.text.isNotEmpty) {
      var requestBody = {
        "userId": userId,
        "weight": _weightController.text,
        "weighed_on": DateTime.now().toString(),
      };

      var response = await http.post(Uri.parse(Config.addWeightEndpoint),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody));

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse["status"]) {
        print("Weight added");
        Navigator.pushNamed(context, '/');
      } else {
        // TODO: Error handling
        print("Weight Failed");
      }
    } else {
      _validate = false;
    }
  }

  void deleteWeight() async {
    if (_weightController.text.isNotEmpty) {
      var requestBody = {
        "userId": userId,
      };

      var response = await http.post(Uri.parse(Config.addWeightEndpoint),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody));

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse["status"]) {
        print("Weight Deleted");
        Navigator.pushNamed(context, '/weight_crud_screen');
      } else {
        // TODO: Error handling
        print("Weight Delete Failed");
      }
    } else {
      _validate = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login_screen');
              },
              child: Icon(Icons.logout_rounded))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Lottie.asset(
                    'assets/lottiefiles/shiba-coffee-relax.json',
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width * 0.45,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      weight = value;
                    },
                    controller: _weightController,
                    // keyboardType: TextInputType.number,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your Weight',
                        prefixIcon: Icon(Icons.scale_rounded)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      addWeight();
                    },
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(color: Color(0xFF333652))),
                      elevation: 10,
                      child: Container(
                        decoration: kLandingScreenButtonsboxDecoration,
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Center(
                          child: Text(
                            'Save',
                            style: kSmallPrimarytTextStyle.copyWith(
                                fontSize: 18, color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteWeight();
        },
        tooltip: 'Delete Wight',
        child: const Icon(Icons.delete),
      ),
    );
  }
}
