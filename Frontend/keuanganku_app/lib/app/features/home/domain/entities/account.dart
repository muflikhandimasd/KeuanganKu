abstract class Account {
  final int id;
  final String userId;
  final String name;

  Account({
    required this.id,
    required this.userId,
    required this.name,
  });

  Map<String, dynamic> toJson();
}
