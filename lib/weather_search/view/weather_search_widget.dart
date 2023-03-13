import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_autocomplete/flutter_async_autocomplete.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/geocoding/model/location_model.dart';
import 'package:klep_weather/weather_search/bloc/weather_search_bloc.dart';

import '../../di/di.dart';

class WeatherSearchField extends StatelessWidget {
  const WeatherSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherSearchBloc>(),
      child: BlocBuilder<WeatherSearchBloc, WeatherSearchState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Column(
            children: [
              TextField(
                onChanged: (valueChanged) =>
                    BlocProvider.of<WeatherSearchBloc>(context).add(
                        AutoCompleteSuggestionsEvent(cityName: valueChanged)),
                onSubmitted: (cityName) =>
                    context
                        .read<WeatherSearchBloc>()
                        .add(WeatherLoadEvent(cityName: cityName)),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',
                ),
              ),
              SizedBox(
                height: 200,
                child: BlocBuilder<WeatherSearchBloc, WeatherSearchState>(
                  buildWhen: (previous, current) {
                    print("cos1 ${state.autoCompleteSuggestions}");
                    return previous != current;
                  },
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.autoCompleteSuggestions.length,
                      itemBuilder: (context, index) {
                        final suggestionItem =
                        state.autoCompleteSuggestions[index];
                        return Expanded(
                            child: ListTile(title: Text(suggestionItem.name)));
                      },
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
