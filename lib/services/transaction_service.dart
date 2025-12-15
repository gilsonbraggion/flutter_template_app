import 'dart:convert';
import 'package:http/http.dart' as http;
import '/domain/entities/transaction_model.dart';

class TransactionService {
  static const String _baseUrl =
      'https://jsonplaceholder.typicode.com/posts'; // exemplo

  Future<List<TransactionModel>> fetchTransactions() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded
          .map((json) => TransactionModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Erro ao carregar posts');
    }
  }
}
