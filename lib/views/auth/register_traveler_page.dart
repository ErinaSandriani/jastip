import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../services/api_service.dart';

class RegisterTravelerPage extends StatefulWidget {

  const RegisterTravelerPage({
    super.key,
  });

  @override
  State<RegisterTravelerPage> createState() =>
      _RegisterTravelerPageState();
}

class _RegisterTravelerPageState
    extends State<RegisterTravelerPage> {

  final namaController = TextEditingController();

  final emailController = TextEditingController();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final noHpController = TextEditingController();

  final alamatController = TextEditingController();

  bool isLoading = false;

  bool obscurePassword = true;

  @override
  void dispose() {

    namaController.dispose();

    emailController.dispose();

    usernameController.dispose();

    passwordController.dispose();

    noHpController.dispose();

    alamatController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF8F8F8),

      appBar: AppBar(

        elevation: 0,

        backgroundColor: Colors.transparent,

        foregroundColor: Colors.black,

        title: const Text(
          "Daftar Traveler",
        ),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.symmetric(

            horizontal: 24,

            vertical: 10,
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Center(

                child: Container(

                  width: 90,

                  height: 90,

                  decoration: BoxDecoration(

                    color: const Color(0xffB71C1C),

                    borderRadius:
                        BorderRadius.circular(22),

                    boxShadow: [

                      BoxShadow(

                        color: const Color(0xffB71C1C)
                            .withOpacity(.25),

                        blurRadius: 15,

                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: const Icon(

                    Icons.flight_takeoff_rounded,

                    color: Colors.white,

                    size: 45,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Center(

                child: Text(

                  "Registrasi Traveler",

                  style: TextStyle(

                    fontSize: 27,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(

                child: Text(

                  "Lengkapi data di bawah ini.\nAkun akan diverifikasi oleh Admin sebelum dapat digunakan.",

                  textAlign: TextAlign.center,

                  style: TextStyle(

                    color: Colors.black54,

                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 35),
                            buildTextField(

                controller: namaController,

                label: "Nama Lengkap",

                icon: Icons.person_outline,
              ),

              const SizedBox(height: 18),

              buildTextField(

                controller: emailController,

                label: "Email",

                icon: Icons.email_outlined,

                keyboardType:
                    TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              buildTextField(

                controller: usernameController,

                label: "Username",

                icon: Icons.alternate_email,
              ),

              const SizedBox(height: 18),

              TextFormField(

                controller: passwordController,

                obscureText: obscurePassword,

                decoration: InputDecoration(

                  labelText: "Password",

                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),

                  suffixIcon: IconButton(

                    onPressed: () {

                      setState(() {

                        obscurePassword =
                            !obscurePassword;

                      });
                    },

                    icon: Icon(

                      obscurePassword

                          ? Icons.visibility_off

                          : Icons.visibility,
                    ),
                  ),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(14),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              buildTextField(

                controller: noHpController,

                label: "Nomor HP",

                icon: Icons.phone_android,

                keyboardType:
                    TextInputType.phone,
              ),

              const SizedBox(height: 18),

              TextFormField(

                controller: alamatController,

                minLines: 3,

                maxLines: 4,

                decoration: InputDecoration(

                  labelText: "Alamat",

                  alignLabelWithHint: true,

                  prefixIcon: const Padding(

                    padding: EdgeInsets.only(
                      bottom: 60,
                    ),

                    child: Icon(
                      Icons.location_on_outlined,
                    ),
                  ),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(14),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 35),
                            SizedBox(

                width: double.infinity,

                height: 55,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                        const Color(0xffB71C1C),

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),

                  onPressed: isLoading
                      ? null
                      : registerTraveler,

                  child: isLoading

                      ? const SizedBox(

                          width: 22,

                          height: 22,

                          child:
                              CircularProgressIndicator(

                            color: Colors.white,

                            strokeWidth: 2,
                          ),
                        )

                      : const Text(

                          "Daftar sebagai Traveler",

                          style: TextStyle(

                            fontSize: 16,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 18),

              Center(

                child: TextButton(

                  onPressed: () {

                    Navigator.pop(context);

                  },

                  child: const Text(

                    "Sudah punya akun? Login",

                    style: TextStyle(

                      color: Color(0xffB71C1C),

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerTraveler() async {

    if (

      namaController.text.isEmpty ||

      emailController.text.isEmpty ||

      usernameController.text.isEmpty ||

      passwordController.text.isEmpty ||

      noHpController.text.isEmpty ||

      alamatController.text.isEmpty

    ){

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content:
              Text("Semua data wajib diisi."),
        ),
      );

      return;
    }

    setState(() {

      isLoading = true;

    });

    try{

      final response = await http.post(

        Uri.parse(

          "${ApiService.baseUrl}/register_traveler.php",

        ),

        body:{

          "nama":namaController.text,

          "email":emailController.text,

          "username":usernameController.text,

          "password":passwordController.text,

          "no_hp":noHpController.text,

          "alamat":alamatController.text,

        },
      );

      final data=jsonDecode(response.body);

      if(data["status"]=="success"){

        if(!mounted) return;

        showDialog(

          context: context,

          barrierDismissible: false,

          builder:(_){

            return AlertDialog(

              title: const Text(

                "Registrasi Berhasil",

              ),

              content: const Text(

                "Akun Traveler berhasil didaftarkan.\n\nSilakan tunggu persetujuan Admin sebelum login.",

              ),

              actions:[

                ElevatedButton(

                  onPressed:(){

                    Navigator.pop(context);

                    Navigator.pop(context);

                  },

                  child: const Text("OK"),
                ),
              ],
            );
          },
        );

      }else{

        if(!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(

            content:
                Text(data["message"]),
          ),
        );
      }

    }catch(e){

      if(!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(e.toString()),
        ),
      );

    }

    if(mounted){

      setState(() {

        isLoading=false;

      });

    }

  }

  Widget buildTextField({

    required TextEditingController controller,

    required String label,

    required IconData icon,

    TextInputType keyboardType =
        TextInputType.text,

  }){

    return TextFormField(

      controller: controller,

      keyboardType: keyboardType,

      decoration: InputDecoration(

        labelText: label,

        prefixIcon: Icon(icon),

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(14),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}