import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout() {
    final _authServices = AuthService();
    _authServices.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, valuue, child) => Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DrawerHeader(
                    child: Center(
                      child: Icon(
                        Icons.message,
                        size: 45,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: ListTile(
                      title: const Text(
                        'H O M E',
                      ),
                      leading: Icon(
                        Icons.home,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: ListTile(
                      title: const Text(
                        'S E T T I N G S',
                      ),
                      leading: Icon(
                        Icons.settings,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Icon(
                          Icons.wb_sunny_outlined,
                          size: 35,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        CupertinoSwitch(
                          value: valuue.isDarkMode,
                          onChanged: (value) {
                            final theme = context.read<ThemeProvider>();
                            theme.toggleTheme();
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.dark_mode_outlined,
                          size: 35,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text(
                    'L O G O U T',
                  ),
                  leading: Icon(
                    Icons.logout,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: logout,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
