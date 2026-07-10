import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../viewmodels/pesanan_viewmodel.dart';

import 'detail_pesanan_admin.dart';

class PesananAdminPage
    extends StatefulWidget {

  const PesananAdminPage({
    super.key,
  });

  @override
  State<PesananAdminPage>
      createState() =>
          _PesananAdminPageState();
}

class _PesananAdminPageState
    extends State<PesananAdminPage> {

  @override
  void initState() {

    super.initState();

    Future.microtask(() {

      context
          .read<PesananViewModel>()
          .getPesanan();
    });
  }

  Color getStatusColor(
    String status,
  ) {

    switch (status) {

      case "Pending":
        return Colors.orange;

      case "Dibeli":
        return Colors.blue;

      case "Dalam Perjalanan":
        return Colors.purple;

      case "Dikirim":
        return Colors.indigo;

      case "Selesai":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    final pesananViewModel =
        context.watch<
            PesananViewModel>();

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Kelola Pesanan",
        ),
      ),

      body:
          pesananViewModel.isLoading

              ? const Center(

                  child:
                      CircularProgressIndicator(),
                )

              : ListView.builder(

                  padding:
                      const EdgeInsets.all(
                    12,
                  ),

                  itemCount:
                      pesananViewModel
                          .pesananList
                          .length,

                  itemBuilder:
                      (context, index) {

                    final pesanan =
                        pesananViewModel
                                .pesananList[
                            index];

                    return Card(

                      margin:
                          const EdgeInsets.only(
                        bottom: 14,
                      ),

                      child: ListTile(

                        title: Text(

                          pesanan
                              .namaBarang,
                        ),

                        subtitle: Text(

                          pesanan.status,

                          style: TextStyle(

                            color:
                                getStatusColor(

                              pesanan
                                  .status,
                            ),

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                        ),

                        onTap: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder:
                                  (_) =>
                                      DetailPesananAdmin(

                                pesanan:
                                    pesanan,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}