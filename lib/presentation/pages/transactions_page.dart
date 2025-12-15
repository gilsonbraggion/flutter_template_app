import 'package:flutter/material.dart';
import '/services/transaction_service.dart';
import '/domain/entities/transaction_model.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late Future<List<TransactionModel>> _future;

  List<TransactionModel> _allTransactions = [];
  List<TransactionModel> _filteredTransactions = [];

  String _searchText = '';
  int? _selectedUserId;

  int _currentPage = 0;
  final int _itemsPerPage = 15;

  @override
  void initState() {
    super.initState();
    _future = TransactionService().fetchTransactions();
  }

  void _applyFilters() {
    setState(() {
      _currentPage = 0;

      _filteredTransactions = _allTransactions.where((t) {
        final matchesText =
            t.title.toLowerCase().contains(_searchText.toLowerCase());
        final matchesUser =
            _selectedUserId == null || t.userId == _selectedUserId;
        return matchesText && matchesUser;
      }).toList();
    });
  }

  List<TransactionModel> _paginatedTransactions() {
    final start = _currentPage * _itemsPerPage;
    final end = start + _itemsPerPage;

    if (start >= _filteredTransactions.length) return [];

    return _filteredTransactions.sublist(
      start,
      end > _filteredTransactions.length
          ? _filteredTransactions.length
          : end,
    );
  }

  Widget _buildFilters() {
    final userIds = _allTransactions
        .map((t) => t.userId)
        .toSet()
        .toList()
      ..sort();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Filtrar por título',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _searchText = value;
              _applyFilters();
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int?>(
            value: _selectedUserId,
            decoration: const InputDecoration(
              labelText: 'Filtrar por User ID',
              border: OutlineInputBorder(),
            ),
            items: [
              const DropdownMenuItem<int?>(
                value: null,
                child: Text('Todos'),
              ),
              ...userIds.map(
                (id) => DropdownMenuItem<int?>(
                  value: id,
                  child: Text('User $id'),
                ),
              ),
            ],
            onChanged: (value) {
              _selectedUserId = value;
              _applyFilters();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
    final pageItems = _paginatedTransactions();

    return LayoutBuilder(
      builder: (context, constraints) {
        final tableHeight = constraints.maxHeight;

        return SizedBox(
          height: tableHeight,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24,
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('UserId')),
                ],
                rows: pageItems
                    .map(
                      (t) => DataRow(
                        cells: [
                          DataCell(Text(t.id.toString())),
                          DataCell(Text(t.title)),
                          DataCell(Text(t.userId.toString())),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaginationControls() {
    final totalPages =
        (_filteredTransactions.length / _itemsPerPage).ceil();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _currentPage > 0
                ? () => setState(() => _currentPage--)
                : null,
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            'Página ${_currentPage + 1} de $totalPages',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: _currentPage < totalPages - 1
                ? () => setState(() => _currentPage++)
                : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionModel>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Erro ao carregar dados:\n${snapshot.error}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        _allTransactions = snapshot.data!;

        if (_filteredTransactions.isEmpty &&
            _searchText.isEmpty &&
            _selectedUserId == null) {
          _filteredTransactions = _allTransactions;
        }

        return Column(
          children: [
            _buildFilters(),
            Expanded(
              child: _buildTable(context),
            ),
            _buildPaginationControls(),
          ],
        );
      },
    );
  }
}
