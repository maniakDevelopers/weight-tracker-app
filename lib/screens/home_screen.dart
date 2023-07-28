import 'package:intl/intl.dart';
import 'package:weight_tracker_app/common/packages.dart';

// Weight History and Delete Weight

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.title});
// TODO: Change this to using provider
  final String title;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email = "";
  String userId = "";

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
    var response = await WeightService.getWeightHistory(userId);

    if (response.status) {
      setState(() {
        weights = (response.data as List)
            .map((data) => WeightModel.fromJson(data))
            .toList();
      });
    } else {
      // TODO: Error handling
      print("Weight Failed");
    }
  }

  void deleteWeight(String weightId) async {
    var response = await WeightService.deleteWeight(weightId);

    if (response.status) {
      Navigator.pushNamed(context, '/home_screen');
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
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.90,
            child: Column(
              children: [
                Lottie.asset(
                  'assets/lottiefiles/shiba-coffee-relax.json',
                  height: MediaQuery.of(context).size.height * 0.25,
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
                Container(
                  child: weights.isEmpty
                      ? Text(
                          'Click the button to add your weight',
                          style: kSmallPrimarytTextStyle.copyWith(fontSize: 20),
                        )
                      : Text(
                          'Weight History',
                          style: kSmallPrimarytTextStyle.copyWith(fontSize: 20),
                        ),
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
                                          'Date : ${DateFormat.yMMMEd().add_jm().format(DateTime.parse(weights[index].weighed_on))}',
                                          style: kSmallPrimarytTextStyle),
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        deleteWeight(weights[index].id);
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
