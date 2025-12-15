import 'package:flutter/material.dart';
import 'profile_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const List<String> users = [
    'Ana Silva',
    'Bruno Costa',
    'Carlos Pereira',
    'Daniela Souza',
    'Eduardo Lima',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final name = users[index];

        return ListTile(
          title: Text(name),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfilePage(userName: name),
              ),
            );
          },
        );
      },
    );
  }
}
