import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/bloc pattern/weather_cubit/weather_cubit.dart';
import 'core/constants/app_colors.dart';
import 'presentation/pages/home page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(),
          child: GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(color: AppColors.appWhite),
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appWhite),
              useMaterial3: true,
            ),
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          ));
    });
  }
}
