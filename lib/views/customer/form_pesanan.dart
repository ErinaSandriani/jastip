import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/traveler_model.dart';
import '../../viewmodels/traveler_viewmodel.dart';
import 'upload_dp_page.dart';

class FormPesananPage extends StatefulWidget {
  final String kategori;

  const FormPesananPage({
    super.key,
    required this.kategori,
  });

  @override
  State<FormPesananPage> createState() =>
      _FormPesananPageState();
}

class _FormPesananPageState
    extends State<FormPesananPage> {

  final namaController =
      TextEditingController();

  final teleponController =
      TextEditingController();

  final provinsiController =
      TextEditingController();

  final kotaController =
      TextEditingController();

  final kodePosController =
      TextEditingController();

  final alamatController =
      TextEditingController();

  final notesController =
      TextEditingController();

  TravelerModel? selectedTraveler;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {

      context
          .read<TravelerViewModel>()
          .getAllTravelers();

    });
  }

  @override
  Widget build(BuildContext context) {

    final travelerVM =
        context.watch<TravelerViewModel>();

    return Scaffold(

      backgroundColor:
          const Color(0xffF5F5F5),

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            Colors.white,

        foregroundColor:
            Colors.black,

        title: const Text(

          "Form Pesanan",

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

            const Text(

              "Kategori",

              style: TextStyle(

                color:
                    Colors.black54,
              ),
            ),

            const SizedBox(height:8),

            Container(

              padding:
                  const EdgeInsets.symmetric(

                horizontal:18,

                vertical:10,
              ),

              decoration: BoxDecoration(

                color:
                    const Color(0xffB71C1C),

                borderRadius:
                    BorderRadius.circular(30),
              ),

              child: Text(

                widget.kategori,

                style:
                    const TextStyle(

                  color: Colors.white,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height:24),

            _buildField(

              controller:
                  namaController,

              label:
                  "Nama Lengkap",

              icon:
                  Icons.person,
            ),

            const SizedBox(height:16),

            _buildField(

              controller:
                  teleponController,

              label:
                  "Nomor Telepon",

              icon:
                  Icons.phone,

              keyboardType:
                  TextInputType.phone,
            ),

            const SizedBox(height:16),

            _buildField(

              controller:
                  provinsiController,

              label:
                  "Provinsi",

              icon:
                  Icons.map,
            ),

            const SizedBox(height:16),

            _buildField(

              controller:
                  kotaController,

              label:
                  "Kota",

              icon:
                  Icons.location_city,
            ),

            const SizedBox(height:16),

            _buildField(

              controller:
                  kodePosController,

              label:
                  "Kode Pos",

              icon:
                  Icons.markunread_mailbox,

              keyboardType:
                  TextInputType.number,
            ),

            const SizedBox(height:16),

            _buildField(

              controller:
                  alamatController,

              label:
                  "Alamat Lengkap",

              icon:
                  Icons.home,

              maxLines:3,
            ),

            const SizedBox(height:16),

            _buildField(

              controller:
                  notesController,

              label:
                  "Detail Barang",

              icon:
                  Icons.inventory_2,

              maxLines:3,
            ),

            const SizedBox(height:20),

            DropdownButtonFormField<TravelerModel>(

              value:
                  selectedTraveler,

              decoration:
                  InputDecoration(

                labelText:
                    "Traveler",

                prefixIcon:
                    const Icon(
                  Icons.flight,
                ),

                filled:true,

                fillColor:
                    Colors.white,

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),

                  borderSide:
                      BorderSide.none,
                ),
              ),

              items:
                  travelerVM.travelerList
                      .map(

                (traveler){

                  return DropdownMenuItem(

                    value:
                        traveler,

                    child: Text(

                      "${traveler.nama} • ${traveler.tanggalPulang}",
                    ),
                  );

                },

              ).toList(),

              onChanged:(value){

                setState((){

                  selectedTraveler =
                      value;

                });

              },

            ),

            const SizedBox(height:20),

            Card(

              elevation:0,

              color:
                  const Color(
                      0xffFDECEC),

              child: Padding(

                padding:
                    const EdgeInsets.all(
                  16,
                ),

                child: Row(

                  children:[

                    const Icon(

                      Icons.payments,

                      color:
                          Color(
                              0xffB71C1C),
                    ),

                    const SizedBox(width:12),

                    const Expanded(

                      child: Text(

                        "Estimasi DP akan ditampilkan setelah pesanan diproses.",

                        style: TextStyle(

                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height:24),

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

                onPressed: () async {

                  if (selectedTraveler ==
                      null) {

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(

                      const SnackBar(

                        content: Text(

                          "Pilih traveler terlebih dahulu",
                        ),
                      ),
                    );

                    return;
                  }

                  final nominalDp =
                      widget.kategori ==
                              "Fashion"

                          ? 150000

                          : widget.kategori ==
                                  "Skincare"

                              ? 100000

                              : widget.kategori ==
                                      "Merchandise"

                                  ? 75000

                                  : 50000;

                  showDialog(

                    context: context,

                    builder: (_) {

                      return AlertDialog(

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),

                        title: const Text(
                          "Pembayaran DP",
                        ),

                        content: Text(

                          "Silakan lakukan pembayaran DP sebesar\n\nRp ${nominalDp.toString()}",
                        ),

                        actions: [

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

                                Navigator.pop(
                                  context,
                                );

                                Navigator.push(

                                  context,

                                  MaterialPageRoute(

                                    builder: (_) =>
                                        UploadDpPage(

                                      kategori:
                                          widget.kategori,

                                      namaLengkap:
                                          namaController.text,

                                      nomorTelepon:
                                          teleponController.text,

                                      provinsi:
                                          provinsiController.text,

                                      kota:
                                          kotaController.text,

                                      kodePos:
                                          kodePosController.text,

                                      alamat:
                                          alamatController.text,

                                      notes:
                                          notesController.text,

                                      travelerId:
                                          selectedTraveler!
                                              .id,
                                    ),
                                  ),
                                );
                              },

                              child: const Text(

                                "Lanjut Pembayaran",
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },

                child: const Text(

                  "Pembayaran DP",

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

  Widget _buildField({

    required TextEditingController
        controller,

    required String label,

    required IconData icon,

    int maxLines = 1,

    TextInputType keyboardType =
        TextInputType.text,

  }) {

    return TextField(

      controller: controller,

      maxLines: maxLines,

      keyboardType:
          keyboardType,

      decoration:
          InputDecoration(

        labelText: label,

        prefixIcon:
            Icon(icon),

        filled: true,

        fillColor:
            Colors.white,

        contentPadding:
            const EdgeInsets.symmetric(

          horizontal: 18,

          vertical: 16,
        ),

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            16,
          ),

          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }
}