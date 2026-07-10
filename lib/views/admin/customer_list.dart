import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../viewmodels/customer_viewmodel.dart';

import 'customer_orders.dart';

class CustomerListPage
    extends StatefulWidget {

  const CustomerListPage({
    super.key,
  });

  @override
  State<CustomerListPage>
      createState() =>
          _CustomerListPageState();
}

class _CustomerListPageState
    extends State<CustomerListPage> {

  @override
  void initState() {

    super.initState();

    Future.microtask(() {

      context

          .read<CustomerViewModel>()

          .getCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {

    final customerViewModel =
        context.watch<
            CustomerViewModel>();

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Daftar Customer",
        ),
      ),

      body:
          customerViewModel
                  .isLoading

              ? const Center(

                  child:
                      CircularProgressIndicator(),
                )

              : ListView.builder(

                  itemCount:
                      customerViewModel
                          .customerList
                          .length,

                  itemBuilder:
                      (context, index) {

                    final customer =
                        customerViewModel
                                .customerList[
                            index];

                    return Card(

                      margin:
                          const EdgeInsets.symmetric(

                        horizontal: 16,

                        vertical: 8,
                      ),

                      child: ListTile(

                        leading:
                            const CircleAvatar(

                          child: Icon(
                            Icons.person,
                          ),
                        ),

                        title: Text(
                          customer.nama,
                        ),

                        subtitle: Text(
                          customer.email,
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
                                      CustomerOrdersPage(

                                customerId:
                                    customer.id,

                                customerName:
                                    customer.nama,
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