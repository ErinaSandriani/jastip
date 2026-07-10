class ProfileModel {

  final int id;

  final String nama;

  final String email;

  final String role;

  ProfileModel({

    required this.id,

    required this.nama,

    required this.email,

    required this.role,
  });

  factory ProfileModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return ProfileModel(

      id: int.parse(
        json["id"].toString(),
      ),

      nama:
          json["nama"] ?? "",

      email:
          json["email"] ?? "",

      role:
          json["role"] ?? "",
    );
  }
}