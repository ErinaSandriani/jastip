class CustomerModel {

  final int id;

  final String nama;

  final String email;

  CustomerModel({

    required this.id,

    required this.nama,

    required this.email,
  });

  factory CustomerModel.fromJson(

    Map<String, dynamic> json,
  ) {

    return CustomerModel(

      id: json["id"],

      nama:
          json["nama"] ?? "",

      email:
          json["email"] ?? "",
    );
  }
}