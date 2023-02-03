import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:klep_weather/main/bloc/main_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListTile(
          leading: Text(AppLocalizations.of(context)!.language),
          trailing: DropdownButton(
            hint: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                BlocProvider.of<MainBloc>(context).state.locale.languageCode,
              ),
            ),
            items: AppLocalizations.supportedLocales
                .map(
                  (locale) => DropdownMenuItem<String>(
                    //todo
                    value: locale.languageCode ?? 'error',
                    child: Text(locale.languageCode ?? 'error'),
                  ),
                )
                .toList(),
            //todo
            onChanged: (value) {
              final languageCodeList = AppLocalizations.supportedLocales
                  .map((locale) => locale.languageCode)
                  .toList();
              if (languageCodeList.contains(value)) {
                BlocProvider.of<MainBloc>(context)
                    .add(LocaleChangedEvent(locale: Locale(value!)));
              }
            },
          ),
        ),
      ),
    );
  }
}
