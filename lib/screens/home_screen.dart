import 'dart:convert';

import 'package:weight_tracker_app/common/packages.dart';
import 'package:http/http.dart' as http;

// Weight History and Delete Weight

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.title});
// TODO: Change this to using provider
  final String title;
  // final String token;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email = "test";
  String userId = "test";

  List<WeightModel> weights = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken =
        JwtDecoder.decode(context.read<TokenProvider>().token!);
    email = jwtDecodedToken["email"];
    userId = jwtDecodedToken["id"];
    getWeightHistory();
  }

  void getWeightHistory() async {
    var requestBody = {
      "userId": userId,
    };

    var response = await http.post(Uri.parse(Config.weightHistoryEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));

    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse["status"]) {
      setState(() {
        weights = (jsonResponse["success"] as List)
            .map((data) => WeightModel.fromJson(data))
            .toList();
      });

      print("Got weight : ${weights.length}");
    } else {
      // TODO: Error handling
      print("Weight Failed");
    }
  }

  void deleteWeight(String weightId) async {
    var requestBody = {
      "id": weightId,
    };

    var response = await http.post(Uri.parse(Config.deleteEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));

    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse["status"]) {
      print("Weight Deleted");
      Navigator.pushNamed(context, '/');
    } else {
      // TODO: Error handling
      print("Weight Delete Failed");
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
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width * 0.90,
            child: Column(
              children: [
                Lottie.asset(
                  'assets/lottiefiles/shiba-coffee-relax.json',
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width * 0.45,
                ),
                Text(
                  'Name :$email',
                  style: kSmallPrimarytTextStyle,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Weight History',
                  style: kSmallPrimarytTextStyle.copyWith(fontSize: 20),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: 4,
                    children: List.generate(weights.length, (index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text('Weight : ${weights[index].weight}',
                                          style: kSmallPrimarytTextStyle),
                                      Text(
                                          'Date : ${weights[index].weighed_on}',
                                          style: kSmallPrimarytTextStyle),
                                      Text('Date : ${weights[index].id}',
                                          style: kSmallPrimarytTextStyle),
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        deleteWeight(weights[index].id);
                                        // Navigator.pushNamed(
                                        //     context, '/weight_crud_screen');
                                      },
                                      child: const Icon(Icons.delete_rounded))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/weight_crud_screen');
        },
        tooltip: 'Add Weight',
        child: const Icon(Icons.add),
      ),
    );
  }
}
