import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

String accessToken = '';

Future<void> checkTokenConfig() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  accessToken = preferences.getString('token') ?? '';
  final String refreshToken = preferences.getString('refreshToken') ?? '';
  if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
    if (decodedToken['UserType'] == '3') {
      Get.offAllNamed('/MainScreenDriverView');
    } else {
      Get.offAllNamed('/MainScreenPassengerView');
    }
  } else {
    accessToken = '';

    Get.offAllNamed('/ChoiceScreenView');
  }
}
