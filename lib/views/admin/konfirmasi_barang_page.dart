import 'package:flutter/material.dart';
import '../../models/pesanan_model.dart';
import '../../services/api_service.dart';

class KonfirmasiBarangPage extends StatefulWidget {
  final Pesanan pesanan;

  const KonfirmasiBarangPage({
    super.key,
    required this.pesanan,
  });

  @override
  State<KonfirmasiBarangPage> createState() =>
      _KonfirmasiBarangPageState();
}

class _KonfirmasiBarangPageState
    extends State<KonfirmasiBarangPage> {
  final hargaController = TextEditingController();
  final feeController = TextEditingController();
  final ongkirController = TextEditingController();

  DateTime? deadline;

  int total = 0;
  int sisa = 0;

  @override
  void initState() {
    super.initState();

    hargaController.addListener(hitungTotal);
    feeController.addListener(hitungTotal);
    ongkirController.addListener(hitungTotal);
  }

  void hitungTotal() {
    final harga = int.tryParse(hargaController.text) ?? 0;
    final fee = int.tryParse(feeController.text) ?? 0;
    final ongkir = int.tryParse(ongkirController.text) ?? 0;

    final totalBayar = harga + fee + ongkir;
    final sisaBayar = totalBayar - widget.pesanan.nominalDp;

    setState(() {
      total = totalBayar;
      sisa = sisaBayar < 0 ? 0 : sisaBayar;
    });
  }

  @override
  void dispose() {
    hargaController.dispose();
    feeController.dispose();
    ongkirController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konfirmasi Barang"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Harga Barang",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: feeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Fee Jastip",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: ongkirController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Ongkir Indonesia",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("DP Customer"),
                      trailing: Text(
                        "Rp ${widget.pesanan.nominalDp}",
                      ),
                    ),

                    const Divider(),

                    ListTile(
                      title: const Text("Total"),
                      trailing: Text(
                        "Rp $total",
                      ),
                    ),

                    ListTile(
                      title: const Text("Sisa Pelunasan"),
                      trailing: Text(
                        "Rp $sisa",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              leading: const Icon(Icons.calendar_today),
              title: Text(
                deadline == null
                    ? "Pilih Deadline Pelunasan"
                    : "${deadline!.day}/${deadline!.month}/${deadline!.year}",
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2035),
                );

                if (picked != null) {
                  setState(() {
                    deadline = picked;
                  });
                }
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (deadline == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Pilih deadline terlebih dahulu",
                        ),
                      ),
                    );
                    return;
                  }

                  final hargaBarang =
                      int.tryParse(hargaController.text) ?? 0;

                  final feeJastip =
                      int.tryParse(feeController.text) ?? 0;

                  final ongkirIndonesia =
                      int.tryParse(ongkirController.text) ?? 0;

                  final totalBayar =
                      hargaBarang + feeJastip + ongkirIndonesia;

                  final response =
                      await ApiService.updatePelunasan(
                    orderId: widget.pesanan.id,
                    hargaBarang: hargaBarang,
                    feeJastip: feeJastip,
                    ongkirIndonesia: ongkirIndonesia,
                    totalBayar: totalBayar,
                    deadlinePelunasan:
                        "${deadline!.year}-${deadline!.month.toString().padLeft(2, '0')}-${deadline!.day.toString().padLeft(2, '0')}",
                  );

                  if (response["status"] == "success") {
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Data berhasil disimpan",
                        ),
                      ),
                    );

                    Navigator.pop(context, true);
                  } else {
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          response["message"],
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  "SIMPAN",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}