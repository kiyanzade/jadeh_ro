import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> checkTokenConfig() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final String token = preferences.getString('token') ?? '';
  final String refreshToken = preferences.getString('refreshToken') ?? '';
  if (token.isNotEmpty && refreshToken.isNotEmpty) {
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    if (decodedToken['UserType'] == '3') {
      Get.offAllNamed('/MainScreenDriverView');
    } else {
      Get.offAllNamed('/MainScreenPassengerView');
    }
  } else {
    Get.offAllNamed('/ChoiceScreenView');
  }
}
