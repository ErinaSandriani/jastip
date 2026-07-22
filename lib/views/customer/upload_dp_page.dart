import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/pesanan_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';

class UploadDpPage extends StatefulWidget {

  final String kategori;
  final String namaLengkap;
  final String nomorTelepon;
  final String provinsi;
  final String kota;
  final String kodePos;
  final String alamat;
  final String notes;
  final int travelerId;

  const UploadDpPage({

    super.key,

    required this.kategori,
    required this.namaLengkap,
    required this.nomorTelepon,
    required this.provinsi,
    required this.kota,
    required this.kodePos,
    required this.alamat,
    required this.notes,
    required this.travelerId,
  });

  @override
  State<UploadDpPage> createState() =>
      _UploadDpPageState();
}

class _UploadDpPageState
    extends State<UploadDpPage> {

  File? selectedImage;

  Future<void> pickImage() async {

    try {

      FilePickerResult? result =
          await FilePicker.platform.pickFiles(

        type: FileType.image,
      );

      if (result != null &&
          result.files.single.path != null) {

        setState(() {

          selectedImage =
              File(result.files.single.path!);

        });
      }

    } catch (e) {

      debugPrint(e.toString());

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Gagal memilih file",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final pesananVM =
        context.watch<PesananViewModel>();

    final nominalDp =
        widget.kategori == "Fashion"

            ? 150000

            : widget.kategori ==
                    "Skincare"

                ? 100000

                : widget.kategori ==
                        "Merchandise"

                    ? 75000

                    : 50000;

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F5F5),

      appBar: AppBar(

        elevation:0,

        backgroundColor:
            Colors.white,

        foregroundColor:
            Colors.black,

        title: const Text(

          "Pembayaran DP",

          style: TextStyle(

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(

              width: double.infinity,

              padding:
                  const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black
                        .withOpacity(.05),

                    blurRadius: 10,

                    offset:
                        const Offset(0,4),
                  ),
                ],
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Row(

                    children: [

                      Icon(

                        Icons.payments,

                        color:
                            Color(0xffB71C1C),
                      ),

                      SizedBox(width:10),

                      Text(

                        "Informasi Pembayaran",

                        style: TextStyle(

                          fontWeight:
                              FontWeight.bold,

                          fontSize:18,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height:20),

                  Text(

                    "Nominal DP",

                    style: TextStyle(

                      color:
                          Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height:4),

                  Text(

                    "Rp ${nominalDp.toString()}",

                    style: const TextStyle(

                      fontSize:24,

                      color:
                          Color(0xffB71C1C),

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const Divider(height:30),

                  const ListTile(

                    contentPadding:
                        EdgeInsets.zero,

                    leading: CircleAvatar(

                      backgroundColor:
                          Color(0xffFDECEC),

                      child: Icon(

                        Icons.account_balance,

                        color:
                            Color(0xffB71C1C),
                      ),
                    ),

                    title: Text(

                      "Bank BCA",

                      style: TextStyle(

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(

                      "1234567890\nA/N Aera Aeri Store",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height:24),

            const Text(

              "Upload Bukti Transfer",

              style: TextStyle(

                fontSize:18,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height:14),

            GestureDetector(

              onTap: pickImage,

              child: Container(

                width: double.infinity,

                height: 230,

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),

                  border: Border.all(

                    color: Colors.grey.shade300,
                  ),
                ),

                child:

                    selectedImage == null

                        ? const Column(

                            mainAxisAlignment:
                                MainAxisAlignment.center,

                            children: [

                              Icon(

                                Icons.cloud_upload_rounded,

                                size:60,

                                color:
                                    Color(0xffB71C1C),
                              ),

                              SizedBox(height:14),

                              Text(

                                "Tap untuk memilih bukti transfer",

                                style: TextStyle(

                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),

                              SizedBox(height:6),

                              Text(

                                "Format JPG / PNG",

                                style: TextStyle(

                                  color:
                                      Colors.black54,
                                ),
                              ),
                            ],
                          )

                        : ClipRRect(

                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),

                            child: Image.file(

                              selectedImage!,

                              fit: BoxFit.cover,
                            ),
                          ),
              ),
            ),

            const SizedBox(height:28),

            SizedBox(

  width: double.infinity,

  height: 55,

  child: ElevatedButton(

    style: ElevatedButton.styleFrom(

      backgroundColor:
          const Color(0xffB71C1C),

      foregroundColor:
          Colors.white,

      elevation: 0,

      shape:
          RoundedRectangleBorder(

        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),
    ),

    onPressed: pesananVM.isLoading

        ? null

        : () async {

            if (selectedImage == null) {

              ScaffoldMessenger.of(context)
                  .showSnackBar(

                const SnackBar(

                  content: Text(

                    "Upload bukti transfer terlebih dahulu",
                  ),
                ),
              );

              return;
            }

            final authVM = context.read<AuthViewModel>();

            pesananVM.currentUserId = authVM.userId;

            final orderId =
                await pesananVM.createOrderGetId(

              kategori:
                  widget.kategori,

              namaLengkap:
                  widget.namaLengkap,

              nomorTelepon:
                  widget.nomorTelepon,

              provinsi:
                  widget.provinsi,

              kota:
                  widget.kota,

              kodePos:
                  widget.kodePos,

              alamat:
                  widget.alamat,

              notes:
                  widget.notes,

              travelerId:
                  widget.travelerId,
            );

            if (orderId == null) {

              if (!mounted) return;

              ScaffoldMessenger.of(context)
                  .showSnackBar(

                const SnackBar(

                  content: Text(

                    "Gagal membuat pesanan",
                  ),
                ),
              );

              return;
            }

            final uploadSuccess =
                await pesananVM.uploadDp(

              orderId: orderId,

              image: selectedImage!,
            );

            if (!mounted) return;

            if (uploadSuccess) {

              showDialog(

                context: context,

                barrierDismissible: false,

                builder: (_) {

                  return AlertDialog(

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),

                    content: Column(

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        const CircleAvatar(

                          radius: 35,

                          backgroundColor:
                              Color(0xffE8F5E9),

                          child: Icon(

                            Icons.check,

                            size: 42,

                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(height:20),

                        const Text(

                          "Pesanan Berhasil",

                          style: TextStyle(

                            fontSize:20,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height:10),

                        const Text(

                          "Bukti pembayaran berhasil dikirim.\nAdmin akan melakukan verifikasi DP Anda.",

                          textAlign:
                              TextAlign.center,

                          style: TextStyle(

                            color:
                                Colors.black54,
                          ),
                        ),

                        const SizedBox(height:22),

                        SizedBox(

                          width:
                              double.infinity,

                          child:
                              ElevatedButton(

                            style:
                                ElevatedButton.styleFrom(

                              backgroundColor:
                                  const Color(
                                      0xffB71C1C),

                              foregroundColor:
                                  Colors.white,
                            ),

                            onPressed: () {

                              Navigator.pop(context);

                              Navigator.popUntil(

                                context,

                                (route) =>
                                    route.isFirst,
                              );
                            },

                            child: const Text(

                              "Selesai",
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );

            } else {

              ScaffoldMessenger.of(context)
                  .showSnackBar(

                const SnackBar(

                  content: Text(

                    "Gagal mengupload bukti transfer",
                  ),
                ),
              );
            }
          },

    child: pesananVM.isLoading

        ? const SizedBox(

            width: 24,

            height: 24,

            child:
                CircularProgressIndicator(

              strokeWidth: 2,

              color: Colors.white,
            ),
          )

        : const Text(

            "Upload Bukti Pembayaran",

            style: TextStyle(

              fontSize: 16,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
  ),
),

const SizedBox(height:30),

],
),
),
);
}
}