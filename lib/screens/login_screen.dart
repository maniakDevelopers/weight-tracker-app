import 'dart:convert';

import 'package:weight_tracker_app/common/packages.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _validate = false;

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void login() async {
    if (_emailController.text.isNotEmpty &
        _passwordController.text.isNotEmpty) {
      var requestBody = {
        "email": _emailController.text,
        "password": _passwordController.text
      };
      print(Config.registerEndpoint);
      print(requestBody);
      var response = await http.post(Uri.parse(Config.loginEndpoint),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody));

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse["success"]);
      if (jsonResponse["status"]) {
        var myToken = jsonResponse["token"];
        prefs.setString("token", myToken);

        context.read<TokenProvider>().getToken(myToken);
        Navigator.pushNamed(context, '/home_screen');
      } else {
        // TODO: Error handling
        print("Failed");
      }
    } else {
      _validate = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottiefiles/shiba-coffee-relax.json',
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    const Column(
                      children: [
                        Text(
                          'Hello Again!',
                          style: kSmallPrimarytTextStyle,
                        ),
                        Text(
                          'Welcome back, we missed you!',
                          style: kSmallPrimarytTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter Username',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Password', prefixIcon: Icon(Icons.lock)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 250,
                  child: GestureDetector(
                      child: Text(
                    'Forgot Password',
                    textAlign: TextAlign.right,
                    style: kSmallSignuptextStyle.copyWith(
                        fontSize: 14, color: Colors.green),
                  )),
                ),
                const SizedBox(
                  height: 45,
                ),
                GestureDetector(
                  onTap: () {
                    login();
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
                          'Login',
                          style: kSmallPrimarytTextStyle.copyWith(
                              fontSize: 18, color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/sign_up_screen');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                      ),
                      Text(
                        ' Sign Up here',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
