import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/pesanan_model.dart';

import '../../models/traveler_model.dart';

import '../../viewmodels/pesanan_viewmodel.dart';

import '../../viewmodels/traveler_viewmodel.dart';

class AssignTravelerPage
    extends StatefulWidget {

  final Pesanan pesanan;

  const AssignTravelerPage({

    super.key,

    required this.pesanan,
  });

  @override
  State<AssignTravelerPage>
      createState() =>
          _AssignTravelerPageState();
}

class _AssignTravelerPageState
    extends State<
        AssignTravelerPage> {

  TravelerModel?
      selectedTraveler;

  @override
  void initState() {

    super.initState();

    Future.microtask(() {

      context

          .read<TravelerViewModel>()

          .getTraveler();
    });
  }

  @override
  Widget build(BuildContext context) {

    final travelerVM =
        context.watch<
            TravelerViewModel>();

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Assign Traveler",
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(16),

        child: Column(

          children: [

            Expanded(

              child:
                  travelerVM.isLoading

                      ? const Center(

                          child:
                              CircularProgressIndicator(),
                        )

                      : ListView.builder(

                          itemCount:
                              travelerVM
                                  .travelerList
                                  .length,

                          itemBuilder:
                              (context,
                                  index) {

                            final traveler =
                                travelerVM
                                        .travelerList[
                                    index];

                            return Card(

                              child:
                                  RadioListTile<
                                      TravelerModel>(

                                value:
                                    traveler,

                                groupValue:
                                    selectedTraveler,

                                onChanged:
                                    (value) {

                                  setState(() {

                                    selectedTraveler =
                                        value;
                                  });
                                },

                                title: Text(
                                  traveler.nama,
                                ),

                                subtitle:
                                    Text(
                                  traveler.email,
                                ),
                              ),
                            );
                          },
                        ),
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(

              width: double.infinity,

              height: 50,

              child: ElevatedButton(

                onPressed: () async {

                  if (selectedTraveler ==
                      null) {

                    return;
                  }

                  await context

                      .read<
                          PesananViewModel>()

                      .assignTraveler(

                        orderId:
                            widget
                                .pesanan
                                .id,

                        travelerId:
                            selectedTraveler!
                                .id,
                      );

                  Navigator.pop(
                    context,
                  );
                },

                child: const Text(
                  "Assign Traveler",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}