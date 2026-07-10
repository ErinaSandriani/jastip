import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/traveler_model.dart';

import '../../viewmodels/traveler_viewmodel.dart';

class PilihTravelerPage
    extends StatefulWidget {

  const PilihTravelerPage({
    super.key,
  });

  @override
  State<PilihTravelerPage>
      createState() =>
          _PilihTravelerPageState();
}

class _PilihTravelerPageState
    extends State<
        PilihTravelerPage> {

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
          "Pilih Traveler",
        ),
      ),

      body:
          travelerVM.isLoading

              ? const Center(

                  child:
                      CircularProgressIndicator(),
                )

              : ListView.builder(

                  padding:
                      const EdgeInsets.all(
                    16,
                  ),

                  itemCount:
                      travelerVM
                          .travelerList
                          .length,

                  itemBuilder:
                      (context, index) {

                    final traveler =
                        travelerVM
                                .travelerList[
                            index];

                    return Card(

                      child:
                          RadioListTile<
                              TravelerModel>(

                        value: traveler,

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

                        subtitle: Text(
                          traveler.email,
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}