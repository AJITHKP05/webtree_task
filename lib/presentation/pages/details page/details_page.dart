import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webtree_task/core/constants/app_colors.dart';
import 'package:webtree_task/presentation/models/weather.dart';
import 'package:webtree_task/presentation/pages/home%20page/home_page.dart';

import '../../../core/bloc pattern/detail_cubit/detail_cubit.dart';
import '../../common widgets/divider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.city});
  final String city;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    context.read<DetailCubit>().getDetail(widget.city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: InkWell(
            onTap: () {
              Get.off(() => const HomePage());
            },
            child: const Text(
              "change location",
              style: TextStyle(color: AppColors.appBlue, fontSize: 18),
            )),
        actions: const [
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<DetailCubit>().getDetail(widget.city);
        },
        child: SingleChildScrollView(
          child: BlocConsumer<DetailCubit, DetailState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is DetailLoading) {
                return SizedBox(
                  height: size.height * .8,
                  child: const Center(
                      child: SpinKitHourGlass(color: AppColors.appPremium)),
                );
              }
              if (state is DetailDataLoaded) {
                Weather data = state.data!;
                var minTemp = data.minTemp ?? 0;
                var maxTemp = data.maxTemp ?? 0;
                var currTemp = data.temp ?? 0;
                var wind = data.windSpeed ?? 0;
                var humidity = data.humidity ?? 0;
                var windDirection = data.windDegrees ?? 0;
                // var maxTemp = data. ?? 0;
                // var currTemp = data.temp ?? 0;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cityName(widget.city),
                      dateWidget(),
                      tempWidget(currTemp),
                      const DividerWidget(),
                      condtionWidget("sunny"),
                      detailWidget(windDirection, humidity, currTemp, maxTemp,
                          minTemp, wind),
                    ]);
              }
              return SizedBox(
                height: size.height * .8,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("No data, please change location"),
                      const SizedBox(
                        height: 10,
                      ),
                      FaIcon(
                        FontAwesomeIcons.hourglass,
                        color: Colors.black,
                        size: size.height * 0.03,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  cityName(String city) {
    return Padding(
      padding: EdgeInsets.only(
        top: 4.sp,
      ),
      child: Align(
        child: Text(
          city,
          style: TextStyle(
            color: Colors.black,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  dateWidget() {
    return Padding(
      padding: EdgeInsets.only(
        top: 5.sp,
      ),
      child: Align(
        child: Text(
          'Today', //day
          style: TextStyle(
            color: Colors.black54,
            fontSize: 28.sp,
          ),
        ),
      ),
    );
  }

  tempWidget(int currTemp) {
    return Padding(
      padding: EdgeInsets.only(
        top: 4.sp,
      ),
      child: Align(
        child: Text(
          '$currTemp˚C', //curent temperature
          style: TextStyle(
            color: currTemp <= 0
                ? Colors.blue
                : currTemp > 0 && currTemp <= 15
                    ? Colors.indigo
                    : currTemp > 15 && currTemp < 30
                        ? Colors.deepPurple
                        : Colors.pink,
            fontSize: 35.sp,
          ),
        ),
      ),
    );
  }

  condtionWidget(String condtion) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5.sp,
      ),
      child: Align(
        child: Text(
          condtion, // weather
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }

  detailWidget(int windDirection, int humidity, int currTemp, int maxTemp,
      int minTemp, double wind) {
    return Column(
      children: [
        tempDiffWidget(maxTemp, minTemp),
        Padding(
          padding: EdgeInsets.all(3.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              displayText("now"),
              displayIcon(FontAwesomeIcons.solidSun),
              displayText("$currTemp˚C"),
              displayIcon(
                FontAwesomeIcons.wind,
              ),
              displayText('$wind km/h'),
              displayIcon(
                FontAwesomeIcons.directions,
              ),
              displayText(
                '$windDirection ˚  ',
              ),
              displayIcon(
                FontAwesomeIcons.thermometer,
              ),
              displayText(
                '$humidity g/m3 ',
              ),
            ],
          ),
        )
      ],
    );
  }

  tempDiffWidget(int maxTemp, int minTemp) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.sp,
        bottom: 1.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$minTemp˚C', // min temperature
            style: TextStyle(
              color: minTemp <= 0
                  ? Colors.blue
                  : minTemp > 0 && minTemp <= 15
                      ? Colors.indigo
                      : minTemp > 15 && minTemp < 30
                          ? Colors.deepPurple
                          : Colors.pink,
              fontSize: 20.sp,
            ),
          ),
          Text(
            '/',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 20.sp,
            ),
          ),
          Text(
            '$maxTemp˚C', //max temperature
            style: TextStyle(
              color: maxTemp <= 0
                  ? Colors.blue
                  : maxTemp > 0 && maxTemp <= 15
                      ? Colors.indigo
                      : maxTemp > 15 && maxTemp < 30
                          ? Colors.deepPurple
                          : Colors.pink,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  displayText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.blueGrey,
        fontSize: 20.sp,
      ),
    );
  }

  displayIcon(IconData icon) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.sp,
        ),
        child: FaIcon(
          icon,
          color: Colors.black,
          size: 22.sp,
        ),
      ),
    );
  }
}
