import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/route_manager.dart';
import 'package:webtree_task/core/bloc%20pattern/weather_cubit/weather_cubit.dart';
import 'package:webtree_task/presentation/pages/details%20page/details_page.dart';

import '../../common widgets/profile_avatar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<WeatherCubit>().getCities();
    super.initState();
  }

  int curent = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text("Weather App"),
        actions: const [
          SizedBox(
            width: 10,
          ),
          ProfileAvatar(),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocConsumer<WeatherCubit, WeatherCubitState>(
            listener: (context, state) {
              if (state is WeatherCubitCitySelected) {
                Get.off(DetailPage());
              }
            },
            builder: (context, state) {
              // print(state);
              if (state is WeatherCubitLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is WeatherCubitCityFetch) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TypeAheadField<String>(
                    suggestionsCallback: (search) => state.city
                        .where((item) =>
                            item.toLowerCase().contains(search.toLowerCase()))
                        .toList(),
                    builder: (context, controller, focusNode) {
                      return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          autofocus: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'City',
                          ));
                    },
                    itemBuilder: (context, city) {
                      return ListTile(
                        title: Text(city),
                      );
                    },
                    onSelected: (city) {
                      context.read<WeatherCubit>().onSelected(city);
                      // print(city);
                    },
                  ),
                ));
              }

              return Container();
            },
          )
        ],
      ),
    );
  }
}
