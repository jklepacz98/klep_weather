import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../main/bloc/main_bloc.dart';

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
        child: DropdownButton(
          //todo remove 'error'
          hint: const Padding(
            padding: EdgeInsets.all(8),
            child: Text('placeholder'),
          ),
          items: AppLocalizations.supportedLocales
              .map(
                (locale) => DropdownMenuItem<String>(
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
    );
  }
}
