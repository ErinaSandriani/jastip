import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../viewmodels/pesanan_viewmodel.dart';

class UpdateStatusPage
    extends StatefulWidget {

  final int orderId;

  final String currentStatus;

  const UpdateStatusPage({

    super.key,

    required this.orderId,

    required this.currentStatus,
  });

  @override
  State<UpdateStatusPage>
      createState() =>
          _UpdateStatusPageState();
}

class _UpdateStatusPageState
    extends State<UpdateStatusPage> {

  late String selectedStatus;

  final List<String> statusList = [

    "Pending",

    "Diproses",

    "Dalam Pengiriman",

    "Selesai",
  ];

  @override
  void initState() {

    super.initState();

    selectedStatus =
        statusList.contains(
              widget.currentStatus,
            )
            ? widget.currentStatus
            : statusList.first;
  }

  @override
  Widget build(BuildContext context) {

    final pesananVM =
        context.watch<PesananViewModel>();

    return Scaffold(

  backgroundColor:
      const Color(0xffF5F5F5),

  appBar: AppBar(

    elevation: 0,

    backgroundColor:
        Colors.white,

    foregroundColor:
        Colors.black,

    centerTitle: true,

    title: const Text(

      "Update Status",

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

      children: [

        Container(

          width: double.infinity,

          padding:
              const EdgeInsets.all(22),

          decoration: BoxDecoration(

            borderRadius:
                BorderRadius.circular(
              22,
            ),

            gradient:
                const LinearGradient(

              begin:
                  Alignment.topLeft,

              end:
                  Alignment.bottomRight,

              colors: [

                Color(0xffE53935),

                Color(0xffB71C1C),
              ],
            ),
          ),

          child: Column(

            children: [

              const CircleAvatar(

                radius: 30,

                backgroundColor:
                    Colors.white,

                child: Icon(

                  Icons.local_shipping,

                  size: 30,

                  color:
                      Color(0xffB71C1C),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              const Text(

                "Perbarui Status Pesanan",

                style: TextStyle(

                  color:
                      Colors.white,

                  fontSize: 20,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Text(

                "Status saat ini : ${widget.currentStatus}",

                style:
                    const TextStyle(

                  color:
                      Colors.white70,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 24,
        ),

        Container(

          width: double.infinity,

          padding:
              const EdgeInsets.all(
            20,
          ),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(
              20,
            ),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black.withOpacity(.05),

                blurRadius: 10,

                offset:
                    const Offset(
                        0,4),
              ),
            ],
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(

                "Pilih Status Baru",

                style: TextStyle(

                  fontSize: 18,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              DropdownButtonFormField<String>(

                value:
                    selectedStatus,

                decoration:
                    InputDecoration(

                  filled: true,

                  fillColor:
                      const Color(
                          0xffF8F8F8),

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),

                    borderSide:
                        BorderSide.none,
                  ),
                ),

                items:
                    statusList.map(

                  (status) {

                    return DropdownMenuItem(

                      value: status,

                      child: Text(
                        status,
                      ),
                    );
                  },
                ).toList(),

                onChanged:
                    (value) {

                  setState(() {

                    selectedStatus =
                        value!;
                  });
                },
              ),

              const SizedBox(
                height: 28,
              ),

            SizedBox(

  width: double.infinity,

  height: 54,

  child: ElevatedButton.icon(

    style:
        ElevatedButton.styleFrom(

      backgroundColor:
          const Color(
              0xffB71C1C),

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

    icon: const Icon(
      Icons.save,
    ),

    label: const Text(

      "Simpan Status",

      style: TextStyle(

        fontSize: 16,

        fontWeight:
            FontWeight.bold,
      ),
    ),

    onPressed: () async {

      final success =
          await pesananVM
              .updateStatus(

        widget.orderId,

        selectedStatus,
      );

      if (!context.mounted) {
        return;
      }

      if (success) {

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(

          const SnackBar(

            content: Text(
              "Status pesanan berhasil diperbarui",
            ),
          ),
        );

        Navigator.pop(
          context,
          true,
        );

      } else {

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(

          const SnackBar(

            content: Text(
              "Gagal memperbarui status",
            ),
          ),
        );
      }
    },
  ),
),
            ],
          ),
        ),
      ],
    ),
  ),
);
  }
}