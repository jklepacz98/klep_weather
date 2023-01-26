import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klep_weather/forecast_list/bloc/forecast_list_bloc.dart';
import 'package:klep_weather/forecast_list/view/forecast_item_widget.dart';

import '../../di/di.dart';

class ForecastListHorizontalWidget extends StatelessWidget {
  const ForecastListHorizontalWidget({required int cityId}) : _cityId = cityId;

  final int _cityId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForecastListBloc>(param1: _cityId),
      child: BlocBuilder<ForecastListBloc, ForecastListState>(
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.forecastList?.length ?? 0,
            itemBuilder: (context, index) {
              //todo get rid of !
              final forecast = state.forecastList![index];
              return ForecastItemWidget(forecastEntity: forecast);
            },
          );
        },
      ),
    );
  }
}
