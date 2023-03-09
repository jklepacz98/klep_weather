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
      body: Column(
        children: [
          ListTile(
            leading: Text(AppLocalizations.of(context)!.language),
            trailing: DropdownButton(
              hint: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  BlocProvider.of<MainBloc>(context).state.locale.languageCode,
                ),
              ),
              items: AppLocalizations.supportedLocales
                  .map((locale) => DropdownMenuItem<String>(
                        value: locale.languageCode,
                        child: Text(locale.languageCode),
                      ))
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
          ListTile(
            leading: Text(AppLocalizations.of(context)!.theme),
            trailing: DropdownButton(
              hint: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  BlocProvider.of<MainBloc>(context)
                      .state
                      .themeMode
                      .translateName(context),
                ),
              ),
              items: ThemeMode.values
                  .map(
                    (themeMode) => DropdownMenuItem<ThemeMode>(
                      value: themeMode,
                      child: Text(themeMode.translateName(context)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                BlocProvider.of<MainBloc>(context)
                    .add(ThemeModeChangedEvent(themeMode: value!));
              },
            ),
          ),
        ],
      ),
    );
  }
}

extension ThemeModeExtension on ThemeMode {
  String translateName(BuildContext context) {
    switch (this) {
      case ThemeMode.light:
        return AppLocalizations.of(context)!.light;
      case ThemeMode.dark:
        return AppLocalizations.of(context)!.dark;
      case ThemeMode.system:
        return AppLocalizations.of(context)!.system;
    }
  }
}
