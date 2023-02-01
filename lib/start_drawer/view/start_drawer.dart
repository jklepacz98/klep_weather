import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:klep_weather/settings/view/settings_page.dart';

class StartDrawer extends StatelessWidget {
  const StartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: SizedBox(),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () async {
              final route = MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              );
              await Navigator.push(context, route);
            },
          ),
        ],
      ),
    );
  }
}
