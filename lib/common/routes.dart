import 'package:weight_tracker_app/common/packages.dart';

var appRoutes = {
  '/': (context) => HomeScreen(
        title: 'Weight Tracker App',
      ),
  '/sign_up_screen': (context) => SignupScreen(),
  '/login_screen': (context) => LoginScreen(),
  '/weight_crud_screen': (context) => WeightCrudScreen(
        title: 'Weight Tracker App',
      ),
};
