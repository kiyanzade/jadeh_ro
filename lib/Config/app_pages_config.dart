import 'package:get/get.dart';
import 'package:jadehro_app/views/common/choice_screen_view.dart';
import 'package:jadehro_app/views/common/help_on_board_screen.dart';
import 'package:jadehro_app/views/common/splash_screen_view.dart';
import 'package:jadehro_app/views/driver/change_phone_screen_driver_view.dart';
import 'package:jadehro_app/views/driver/home_screen_driver_view.dart';
import 'package:jadehro_app/views/driver/main_screen_driver_view.dart';
import 'package:jadehro_app/views/driver/register_screen_driver_view.dart';
import 'package:jadehro_app/views/driver/request_list_driver_view.dart';
import 'package:jadehro_app/views/driver/travel_detail_driver_view.dart';
import 'package:jadehro_app/views/driver/travel_reg_screen_view.dart';
import 'package:jadehro_app/views/driver/verify_code_driver_view.dart';
import 'package:jadehro_app/views/passenger/change_phone_screen_view_passenger.dart';
import 'package:jadehro_app/views/passenger/home_screen_passenger_filter_view.dart';
import 'package:jadehro_app/views/passenger/home_screen_passenger_view.dart';
import 'package:jadehro_app/views/passenger/main_screen_passenger_view.dart';
import 'package:jadehro_app/views/passenger/register_screen_view_passenger.dart';
import 'package:jadehro_app/views/passenger/travel_detail_passenger_view.dart';
import 'package:jadehro_app/views/passenger/trip_request_passenger_list_view.dart';
import 'package:jadehro_app/views/passenger/verify_code_passenger_view.dart';


class AppPages {
  static final GetPage<dynamic> splashScreenView = GetPage(
    name: '/',
    page: () => const SplashScreenView(),
  );
  static final GetPage<dynamic> choiseScreenView = GetPage(
    name: '/ChoiceScreenView',
    page: () => const ChoiceScreenView(),
  );
  static final GetPage<dynamic> registerDriverView = GetPage(
    name: '/RegisterDriverView',
    page: () => const RegisterDriverView(),
  );
  static final GetPage<dynamic> registerPassengerView = GetPage(
    name: '/RegisterPassengerView',
    page: () => const RegisterPassengerView(),
  );
  static final GetPage<dynamic> selectCityView = GetPage(
    name: '/SelectCityView',
    page: () => const TripRequestPassengerListView(),
  );
  static final GetPage<dynamic> verifyCodePassengerView = GetPage(
    name: '/VerifyCodePassengerView',
    page: () => const VerifyCodePassengerView(),
  );
  static final GetPage<dynamic> verifyCodeDriverView = GetPage(
    name: '/VerifyCodeDriverView',
    page: () => const VerifyCodeDriverView(),
  );
  static final GetPage<dynamic> mainScreenPassengerView = GetPage(
    name: '/MainScreenPassengerView',
    page: () => const MainScreenPassengerView(),
  );
  static final GetPage<dynamic> mainScreenDriverView = GetPage(
    name: '/MainScreenDriverView',
    page: () => const MainScreenDriverView(),
  );
  static final GetPage<dynamic> selectCityScreen = GetPage(
    name: '/SelectCityScreenView',
    page: () => const TripRequestPassengerListView(),
  );
  static final GetPage<dynamic> homeDriverScreen = GetPage(
    name: '/HomeDriverScreen',
    page: () => const HomeDriverScreen(),
  );
  static final GetPage<dynamic> homePassengerScreen = GetPage(
    name: '/HomePassengerScreen',
    page: () => const HomePassengerScreen(),
  );
  static final GetPage<dynamic> homeScreenFilterView = GetPage(
    name: '/HomeScreenFilterView',
    page: () => const HomeScreenFilterView(),
  );
  static final GetPage<dynamic> travelDetailPassengerView = GetPage(
    name: '/TravelDetailPassengerView',
    page: () => const TravelDetailPassengerView(),
  );
  static final GetPage<dynamic> travelDetailFriverView = GetPage(
    name: '/TravelDetailDriverView',
    page: () => const TravelDetailDriverView(),
  );
  static final GetPage<dynamic> helpOnBoardScreen = GetPage(
    name: '/HelpOnBoardScreen',
    page: () => const HelpOnBoardScreen(),
  );
  static final GetPage<dynamic> changephonedriverview = GetPage(
    name: '/ChangePhoneDriverView',
    page: () => const ChangePhoneDriverView(),
  );
  static final GetPage<dynamic> changephonepassengerview = GetPage(
    name: '/ChangePhonePassengerView',
    page: () => const ChangePhonePassengerView(),
  );
  static final GetPage<dynamic> requestsListDriverView = GetPage(
    name: '/RequestsDriverView',
    page: () => const RequestsListDriverView(),
  );
  static final GetPage<dynamic> tripRequestPassengerListView = GetPage(
    name: '/TripRequestPassengerListView',
    page: () => const TripRequestPassengerListView(),
  );
  static final GetPage<dynamic> tripRegisterDriver = GetPage(
    name: '/TripRegisterDriver',
    page: () => const TravelOnboarding(),
  );
}
