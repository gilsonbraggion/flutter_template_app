class TransactionModel {
  final int id;
  final String title;
  final int userId;

  TransactionModel({
    required this.id,
    required this.title,
    required this.userId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
    );
  }
}
