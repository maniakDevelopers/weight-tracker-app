import 'package:weight_tracker_app/common/packages.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken =
        JwtDecoder.decode(context.read<TokenProvider>().token!);
    email = jwtDecodedToken["email"];
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
                // Text(
                //   'Name :${context.watch<TokenProvider>().token}',
                //   style: kSmallPrimarytTextStyle,
                // ),
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
                    children: List.generate(4, (index) {
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
                                  const Text('Weight Information',
                                      style: kSmallPrimarytTextStyle),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/weight_crud_screen');
                                      },
                                      child: Icon(Icons.delete_rounded))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                // Card(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(5.0),
                //   ),
                //   child: const Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       Text('Wheight Information',
                //           style: kSmallPrimarytTextStyle),
                //       Icon(Icons.delete_rounded)
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/weight_crud_screen');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
