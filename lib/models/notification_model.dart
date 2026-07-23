class NotificationModel {
  final int id;
  final String judul;
  final String pesan;
  final bool isRead;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.judul,
    required this.pesan,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return NotificationModel(
      id: int.parse(json["id"].toString()),
      judul: json["judul"] ?? "",
      pesan: json["pesan"] ?? "",
      isRead: json["is_read"].toString() == "1",
      createdAt: json["created_at"] ?? "",
    );
  }
}