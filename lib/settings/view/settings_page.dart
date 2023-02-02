import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:klep_weather/di/di.dart';
import 'package:klep_weather/settings/bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SettingsBloc>(),
      child: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          AppLocalizations.delegate.load(Locale(state.countryCode));
        },
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.settings),
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: () => context
                      .read<SettingsBloc>()
                      .add(LanguageChangedEvent(countryCode: 'en'))),
            );
          },
        ),
      ),
    );
  }
}
