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

  @override
  void initState() {
    super.initState();
    _future = TransactionService().fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TransactionModel>>(
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
                  'Erro:\n${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final transactions = snapshot.data!;

          return SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Title')),
              ],
              rows: transactions
                  .map(
                    (t) => DataRow(
                      cells: [
                        DataCell(Text(t.id.toString())),
                        DataCell(Text(t.title)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
