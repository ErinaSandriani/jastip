import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'
    as http;

import '../../services/api_service.dart';

class CustomerOrdersPage
    extends StatefulWidget {

  final int customerId;

  final String customerName;

  const CustomerOrdersPage({

    super.key,

    required this.customerId,

    required this.customerName,
  });

  @override
  State<CustomerOrdersPage>
      createState() =>
          _CustomerOrdersPageState();
}

class _CustomerOrdersPageState
    extends State<CustomerOrdersPage> {

  bool isLoading = true;

  List orders = [];

  @override
  void initState() {

    super.initState();

    getOrders();
  }

  Future<void> getOrders()
  async {

    try {

      final response =
          await http.get(

        Uri.parse(

          "${ApiService.baseUrl}/get_customer_orders.php?user_id=${widget.customerId}",
        ),
      );

      final data =
          jsonDecode(response.body);

      if (data["status"] ==
          "success") {

        orders = data["data"];
      }

    } catch (e) {

      debugPrint(e.toString());
    }

    setState(() {

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(
          widget.customerName,
        ),
      ),

      body: isLoading

          ? const Center(

              child:
                  CircularProgressIndicator(),
            )

          : orders.isEmpty

              ? const Center(

                  child: Text(
                    "Belum ada pesanan",
                  ),
                )

              : ListView.builder(

                  itemCount:
                      orders.length,

                  itemBuilder:
                      (context, index) {

                    final order =
                        orders[index];

                    return Card(

                      margin:
                          const EdgeInsets.symmetric(

                        horizontal: 16,

                        vertical: 8,
                      ),

                      child: Padding(

                        padding:
                            const EdgeInsets.all(
                          12,
                        ),

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(

                              order["kategori"] ??
                                  "-",

                              style:
                                  const TextStyle(

                                fontSize: 18,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Text(
                              order["notes"] ??
                                  "",
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Text(

                              "Status: ${order["status"]}",
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Text(

                              "Nominal DP: Rp ${order["nominal_dp"] ?? 0}",
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            if (order["dp_bukti"] !=
                                    null &&
                                order["dp_bukti"]
                                    .toString()
                                    .isNotEmpty)

                              ElevatedButton.icon(

                                onPressed: () {

                                  showDialog(

                                    context:
                                        context,

                                    builder: (_) {

                                      return Dialog(

                                        child:
                                            InteractiveViewer(

                                          child:
                                              Image.network(

                                            "${ApiService.baseUrl}/${order["dp_bukti"]}",
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },

                                icon: const Icon(
                                  Icons.image,
                                ),

                                label: const Text(
                                  "Lihat Bukti DP",
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}