import 'package:weight_tracker_app/common/packages.dart';

// TODO: Use the correct appRoutes
var appRoutes = {
  '/': (context) => SignupScreen(),
  '/home_screen': (context) => HomeScreen(
        title: '',
      ),
  '/login_screen': (context) => LoginScreen(),
  '/weight_crud_screen': (context) => WeightCrudScreen(
        title: 'Weight Tracker App',
      ),
  '/sign_up_screen': (context) => SignupScreen(),
};

var appRoutes2 = {
  '/': (context) => HomeScreen(
        title: 'Weight Tracker App',
      ),
  '/sign_up_screen': (context) => SignupScreen(),
  '/login_screen': (context) => LoginScreen(),
  '/weight_crud_screen': (context) => WeightCrudScreen(
        title: 'Weight Tracker App',
      ),
};
