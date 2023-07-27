import 'package:weight_tracker_app/common/packages.dart';

const bodyText1TextStyle =
    TextStyle(fontSize: 24.0, fontFamily: "Chewy", color: Color(0xFF333652));

const hintTextTextStyle =
    TextStyle(fontSize: 14.0, fontFamily: "Chewy", color: Colors.blueGrey);
const hintErrorTextTextStyle =
    TextStyle(fontSize: 14.0, fontFamily: "Chewy", color: Colors.red);

const kTextFieldDecoration = InputDecoration(
  constraints: BoxConstraints(maxWidth: 300, maxHeight: 45),
  prefixIcon: Icon(Icons.person),
  prefixIconColor: Color(0xFF333652),
  hintText: 'Enter a value',
  hintStyle: hintTextTextStyle,
  errorStyle: hintErrorTextTextStyle,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

var kLandingScreenButtonsboxDecoration = BoxDecoration(
    // boxShadow: const [
    //   BoxShadow(color: Colors.white, spreadRadius: 0, blurRadius: 10),
    // ],
    shape: BoxShape.rectangle,
    color: const Color(0xFF333652),
    borderRadius: BorderRadius.circular(15));
const kSmallSignuptextStyle =
    TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
const kSmallPrimarytTextStyle =
    TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold);
const kSandingScreenMidtextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.green,
    fontFamily: "ArchitectsDaughter");
