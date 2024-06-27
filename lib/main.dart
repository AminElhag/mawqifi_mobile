import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common/http_override.dart';
import 'package:mawqifi/features/auth/mobile_login/presentations/cubit/mobile_login/mobile_login_cubit.dart';
import 'package:mawqifi/features/auth/mobile_login/presentations/cubit/otp/otp_cubit.dart';
import 'package:mawqifi/features/booking/presentation/cubit/booking/booking_cubit.dart';
import 'package:mawqifi/features/booking/presentation/cubit/booking_list/booking_list_cubit.dart';
import 'package:mawqifi/features/main/presentations/page/main_page.dart';
import 'package:mawqifi/features/parking/presentations/cubit/parking/parking_cubit.dart';
import 'package:mawqifi/features/parking/presentations/cubit/parking_details/parking_details_cubit.dart';
import 'package:mawqifi/features/proflie/presentations/cubit/create_profile/create_profile_cubit.dart';
import 'package:mawqifi/features/splash_screen/presentation/pages/splash_screen_one.dart';
import 'package:mawqifi/features/vehicle/presentations/cubit/add_vehicle/add_vehicle_cubit.dart';
import 'package:mawqifi/features/vehicle/presentations/cubit/vehicle_list/vehicle_list_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

void main() async {
  HttpOverrides.global = HttpOverride();
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  configLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MobileLoginCubit(),
        ),
        BlocProvider(
          create: (context) => OtpCubit(),
        ),
        BlocProvider(
          create: (context) => CreateProfileCubit(),
        ),
        BlocProvider(
          create: (context) => AddVehicleCubit(),
        ),
        BlocProvider(
          create: (context) => ParkingCubit(),
        ),
        BlocProvider(
          create: (context) => ParkingDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => BookingCubit(),
        ),
        BlocProvider(
          create: (context) => BookingListCubit(),
        ),
        BlocProvider(
          create: (context) => VehicleListCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Mawqifi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "SF-Pro",
          scaffoldBackgroundColor: TColor.bg,
          colorScheme: ColorScheme.fromSeed(seedColor: TColor.lightGray),
          appBarTheme: const AppBarTheme(color: Colors.transparent),
          useMaterial3: true,
        ),
        home: (Globs.udValueBool(PreferenceKey.userLogin))
            ? const MainPage()
            : const SplashScreenOne(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 5.0
    ..progressColor = TColor.secondaryText
    ..backgroundColor = TColor.primary
    ..indicatorColor = TColor.secondary
    ..textColor = TColor.secondaryText
    ..userInteractions = false
    ..dismissOnTap = false;
}
