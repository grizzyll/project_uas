import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AppProvider>(context);
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(prov.username ?? 'Guest'),
            accountEmail: Text(prov.role?.toString().split('.').last ?? ''),
          ),
          ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text('Reload data'),
            onTap: () => prov.loadAll(),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              prov.logout();
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
