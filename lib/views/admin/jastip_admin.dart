import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/traveler_model.dart';
import '../../viewmodels/traveler_viewmodel.dart';
import '../../viewmodels/kategori_dp_viewmodel.dart';
import '../../models/rekening_model.dart';
import '../../viewmodels/rekening_viewmodel.dart';

import 'detail_traveler_admin.dart';

class JastipAdminPage extends StatefulWidget {
  const JastipAdminPage({super.key});

  @override
  State<JastipAdminPage> createState() => _JastipAdminPageState();
}

class _JastipAdminPageState extends State<JastipAdminPage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  final TextEditingController searchController =
      TextEditingController();
  
  final Map<int, TextEditingController> _dpControllers = {};


  String keyword = "";

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    Future.microtask(() {
      context.read<TravelerViewModel>().getAllTravelers();
      context.read<KategoriDPViewModel>().getKategoriDP();
      context.read<RekeningViewModel>().getRekening();
    });
  }

  @override
void dispose() {
  for (final controller in _dpControllers.values) {
    controller.dispose();
  }
  super.dispose();
}

  Color getStatusColor(String status) {

        switch (status) {
      case "pending":
        return Colors.orange;

      case "approved":
        return Colors.green;

      case "rejected":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case "pending":
        return "Pending";

      case "approved":
        return "Aktif";

      case "rejected":
        return "Ditolak";

      default:
        return status;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "pending":
        return Icons.hourglass_top;

      case "approved":
        return Icons.verified;

      case "rejected":
        return Icons.cancel;

      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final travelerVM = context.watch<TravelerViewModel>();
    final kategoriDpVM = context.watch<KategoriDPViewModel>();
    final rekeningVM = context.watch<RekeningViewModel>();

    return Scaffold(

            backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Jastip",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xffB71C1C),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xffB71C1C),
          tabs: const [
            Tab(
              icon: Icon(Icons.flight_takeoff),
              text: "Traveler",
            ),
            Tab(
              icon: Icon(Icons.payments),
              text: "Nominal DP",
            ),
            Tab(
              icon: Icon(Icons.account_balance),
              text: "Pembayaran",
        ),
          ],
        ),
      ),


      body: TabBarView(
        controller: _tabController,
        children: [

          /// =========================
          /// TAB TRAVELER
          /// =========================
          travelerVM.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [

                                        Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            keyword = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText:
                              "Cari nama atau email traveler...",
                          prefixIcon:
                              const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Builder(
                        builder: (context) {

                          final List<TravelerModel> list =
    travelerVM.travelerList.where(
                            (traveler) {
                              return traveler.nama
                                      .toLowerCase()
                                      .contains(
                                        keyword.toLowerCase(),
                                      ) ||
                                  traveler.email
                                      .toLowerCase()
                                      .contains(
                                        keyword.toLowerCase(),
                                      );
                            },
                          ).toList();

                                                    if (list.isEmpty) {
                            return const Center(
                              child: Text(
                                "Data traveler tidak ditemukan",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: list.length,
                            itemBuilder: (context, index) {

                              final traveler = list[index];

                              return Container(
                                margin: const EdgeInsets.only(
                                  bottom: 18,
                                ),
                                padding: const EdgeInsets.all(
                                  18,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(
                                    22,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(.05),
                                      blurRadius: 10,
                                      offset: const Offset(
                                        0,
                                        4,
                                      ),
                                    ),
                                  ],
                                ),

                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [

                                                                Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 24,
                                          backgroundColor:
                                              Color(0xffFDECEC),
                                          child: Icon(
                                            Icons.flight_takeoff,
                                            color: Color(0xffB71C1C),
                                          ),
                                        ),

                                        const SizedBox(width: 14),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                traveler.nama,
                                                style:
                                                    const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 4,
                                              ),

                                              Text(
                                                traveler.email,
                                                style:
                                                    const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: getStatusColor(
                                              traveler
                                                  .statusVerifikasi,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize:
                                                MainAxisSize.min,
                                            children: [

                                                                                            Icon(
                                                getStatusIcon(
                                                  traveler
                                                      .statusVerifikasi,
                                                ),
                                                color: Colors.white,
                                                size: 16,
                                              ),

                                              const SizedBox(
                                                width: 6,
                                              ),

                                              Text(
                                                getStatusText(
                                                  traveler
                                                      .statusVerifikasi,
                                                ),
                                                style:
                                                    const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 18,
                                    ),

                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          size: 18,
                                          color: Colors.grey,
                                        ),

                                        const SizedBox(width: 8),

                                        Expanded(
                                          child: Text(
                                            traveler
                                                    .tanggalPulang
                                                    .isEmpty
                                                ? "Belum mengisi tanggal pulang"
                                                : traveler
                                                    .tanggalPulang,
                                          ),
                                        ),
                                      ],
                                    ),

                                                                        const SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          size: 18,
                                          color: Colors.grey,
                                        ),

                                        const SizedBox(width: 8),

                                        Expanded(
                                          child: Text(
                                            traveler.noHp,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),

                                    SizedBox(
                                      width: double.infinity,
                                      height: 48,
                                      child: ElevatedButton.icon(
                                        style:
                                            ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffB71C1C),
                                          foregroundColor:
                                              Colors.white,
                                          elevation: 0,
                                          shape:
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.visibility,
                                        ),
                                        label: const Text(
                                          "Lihat Detail",
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  DetailTravelerAdmin(
                                                traveler: traveler,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),

                          /// =========================
          /// TAB NOMINAL DP
          /// =========================
          kategoriDpVM.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: kategoriDpVM.kategoriDP.length,
                  itemBuilder: (context, index) {

                    final item =
                        kategoriDpVM.kategoriDP[index];

                    final controller = _dpControllers.putIfAbsent(
  item.id,
  () => TextEditingController(),
);

if (controller.text != item.nominalDp.toString()) {
  controller.text = item.nominalDp.toString();
}

                    return Card(
                      margin:
                          const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Text(
                              item.kategori,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 16),

                            TextField(
                              controller: controller,
                              keyboardType:
                                  TextInputType.number,
                              decoration:
                                  const InputDecoration(

                                                                    labelText: "Nominal DP",
                                prefixText: "Rp ",
                                border: OutlineInputBorder(),
                              ),
                            ),

                            const SizedBox(height: 16),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xffB71C1C),
                                  foregroundColor:
                                      Colors.white,
                                ),
                                onPressed: () async {

  final messenger = ScaffoldMessenger.of(context);

  final nominal =
      int.tryParse(controller.text) ?? 0;

  final success =
      await kategoriDpVM.updateKategoriDP(
    id: item.id,
    nominalDp: nominal,
  );

  controller.text = nominal.toString();

  if (!mounted) return;

  messenger.showSnackBar(
    SnackBar(
      content: Text(
        success
            ? "Nominal DP berhasil diperbarui"
            : "Gagal memperbarui Nominal DP",
      ),
    ),
  );
},
                                child: const Text(
                                  "Simpan",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

rekeningVM.isLoading
    ? const Center(
        child: CircularProgressIndicator(),
      )
    : Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Tambah Metode Pembayaran"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffB71C1C),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                _showRekeningDialog(context);
                },
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: rekeningVM.rekening.length,
              itemBuilder: (context, index) {

                final item = rekeningVM.rekening[index];

                return _rekeningCard(item);

              },
            ),
          ),

        ],
      )

        ],
      ),
    );
  }
Widget _rekeningCard(RekeningModel item) {

  return Card(

    margin: const EdgeInsets.only(bottom: 16),

    elevation: 2,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),

    child: Padding(

      padding: const EdgeInsets.all(16),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              const CircleAvatar(
                backgroundColor: Color(0xffFDECEC),
                child: Icon(
                  Icons.account_balance,
                  color: Color(0xffB71C1C),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(

                child: Text(

                  item.metodePembayaran,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),

                ),

              ),

            ],

          ),

          const SizedBox(height: 16),

          Text(
            "Nomor Rekening",
            style: TextStyle(color: Colors.grey),
          ),

          Text(
            item.nomorRekening,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 12),

          Text(
            "Atas Nama",
            style: TextStyle(color: Colors.grey),
          ),

          Text(
            item.atasNama,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 20),

          Row(

            mainAxisAlignment: MainAxisAlignment.end,

            children: [

              TextButton.icon(

                onPressed: () {

                  _showRekeningDialog(
                    context,
                    rekening: item,
                  );

                },

                icon: const Icon(Icons.edit),

                label: const Text("Edit"),

              ),

              const SizedBox(width: 10),

              TextButton.icon(

                onPressed: () {

                  _hapusRekening(item.id);

                },

                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),

                label: const Text(
                  "Hapus",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

}

Future<void> _hapusRekening(int id) async {

  final rekeningVM = context.read<RekeningViewModel>();

  final messenger = ScaffoldMessenger.of(context);

  final confirm = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text("Hapus Metode Pembayaran"),
        content: const Text(
          "Apakah Anda yakin ingin menghapus metode pembayaran ini?",
        ),
        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, false);
            },
            child: const Text("Batal"),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(dialogContext, true);
            },
            child: const Text("Hapus"),
          ),

        ],
      );
    },
  );

  if (confirm != true) return;

  final success = await rekeningVM.deleteRekening(id);

  if (!mounted) return;

  messenger.showSnackBar(
    SnackBar(
      content: Text(
        success
            ? "Metode pembayaran berhasil dihapus"
            : "Gagal menghapus metode pembayaran",
      ),
    ),
  );
}

Future<void> _showRekeningDialog(
  BuildContext context, {
  RekeningModel? rekening,
}) async {

final metodeController = TextEditingController(
  text: rekening?.metodePembayaran ?? "",
);

final nomorController = TextEditingController(
  text: rekening?.nomorRekening ?? "",
);

final atasNamaController = TextEditingController(
  text: rekening?.atasNama ?? "",
);

final rekeningVM = context.read<RekeningViewModel>();

final messenger = ScaffoldMessenger.of(context);

await showDialog(

  context: context,

  builder: (dialogContext) {

    return AlertDialog(

      title: Text(
        rekening == null
            ? "Tambah Metode Pembayaran"
            : "Edit Metode Pembayaran",
      ),

      content: SingleChildScrollView(

        child: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            TextField(
              controller: metodeController,
              decoration: const InputDecoration(
                labelText: "Metode Pembayaran",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: nomorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Nomor Rekening",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: atasNamaController,
              decoration: const InputDecoration(
                labelText: "Atas Nama",
              ),
            ),

          ],

        ),

      ),

      actions: [

        TextButton(

          onPressed: () {
            Navigator.pop(dialogContext);
            
          },

          child: const Text("Batal"),

        ),

        ElevatedButton(

          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffB71C1C),
            foregroundColor: Colors.white,
          ),

          onPressed: () async {

            bool success;

            if (rekening == null) {

              success = await rekeningVM.tambahRekening(

                metodePembayaran: metodeController.text.trim(),

                nomorRekening: nomorController.text.trim(),

                atasNama: atasNamaController.text.trim(),

              );

            } else {

              success = await rekeningVM.updateRekening(

                id: rekening.id,

                metodePembayaran: metodeController.text.trim(),

                nomorRekening: nomorController.text.trim(),

                atasNama: atasNamaController.text.trim(),

              );

            }

            if (!mounted) return;

            Navigator.pop(dialogContext);

            messenger.showSnackBar(

              SnackBar(

                content: Text(

                  success
                      ? "Data berhasil disimpan"
                      : "Gagal menyimpan data",
                ),
              ),
            );
          },
          child: const Text("Simpan"),
        ),
      ],
    );
  },
);
//metodeController.dispose();
//nomorController.dispose();
//atasNamaController.dispose();
}
}
