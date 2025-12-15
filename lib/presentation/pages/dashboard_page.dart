import 'package:flutter/material.dart';
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _searchController = TextEditingController();

  static const List<String> _allUsers = [
    'Ana Silva',
    'Bruno Costa',
    'Carlos Pereira',
    'Daniela Souza',
    'Eduardo Lima',
    'Fernanda Rocha',
    'Gabriel Martins',
  ];

  List<String> _filteredUsers = _allUsers;

  void _filterUsers(String value) {
    setState(() {
      _filteredUsers = _allUsers
          .where(
            (name) => name.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔍 Campo de busca estilo iOS
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onChanged: _filterUsers,
            decoration: InputDecoration(
              hintText: 'Buscar',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // 📋 Lista filtrada
        Expanded(
          child: _filteredUsers.isEmpty
              ? const Center(
                  child: Text('Nenhum resultado encontrado'),
                )
              : ListView.separated(
                  itemCount: _filteredUsers.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final name = _filteredUsers[index];

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
                ),
        ),
      ],
    );
  }
}
