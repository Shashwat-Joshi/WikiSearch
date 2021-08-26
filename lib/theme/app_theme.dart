import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static Color primaryColor = Color(0xff1E1E1E);
  static Color searchScreenBGColor = Color(0xff2F3133);
  static Color searchButtonColor = Color(0xff2F3133);
  static Color blueColor = Color(0xff56A0EA);

  static var logoStyle = GoogleFonts.montserrat(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static var searchTextStyle = GoogleFonts.montserrat(
    color: Color(0xff7A7E81),
    fontSize: 15.0,
  );

  static var headerStyle = GoogleFonts.montserrat(
    fontSize: 22.0,
    color: Color(0xff56A0EA),
  );

  static var errorMessageSmallTextStyle = GoogleFonts.montserrat(
    fontSize: 15.0,
    color: Color(0xffBDC1C2),
  );
}
