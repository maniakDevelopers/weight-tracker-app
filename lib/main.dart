import 'package:weight_tracker_app/common/packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String myValue = prefs.getString('myValue') ?? "";
  String? retrievedToken = await retrieveToken();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TokenProvider()..getToken(myValue)),
      ],
      child: MyApp(
        token: prefs.getString("token"),
      ),
    ),
  );
}

Future<String?> retrieveToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({super.key, required this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weight Tracker App',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'ArchitectsDaughter',
              bodyColor: Colors.green,
            ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // TODO: Uncomment the routes
      initialRoute: JwtDecoder.isExpired(token) == false
          ? '/home_screen'
          : '/login_screen',
      routes: appRoutes,
      // home: SignupScreen(),
    );
  }
}
