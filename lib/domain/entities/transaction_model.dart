class TransactionModel {
  final int id;
  final String title;

  TransactionModel({
    required this.id,
    required this.title,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
