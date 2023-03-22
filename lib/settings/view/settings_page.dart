import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:klep_weather/main/bloc/main_bloc.dart';

import '../../di/di.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: BlocProvider(
        create: (context) => getIt<MainBloc>(),
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              child: ListTile(
                leading: Text(AppLocalizations.of(context)!.language),
                trailing: DropdownButton(
                  hint: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(state.locale.languageCode),
                  ),
                  items: AppLocalizations.supportedLocales
                      .map(
                        (locale) => DropdownMenuItem<String>(
                          value: locale.languageCode,
                          child: Text(locale.languageCode),
                        ),
                      )
                      .toList(),
                  //todo
                  onChanged: (value) {
                    final languageCodeList = AppLocalizations.supportedLocales
                        .map((locale) => locale.languageCode)
                        .toList();
                    if (languageCodeList.contains(value)) {
                      context
                          .read<MainBloc>()
                          .add(LocaleChangedEvent(locale: Locale(value!)));
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
