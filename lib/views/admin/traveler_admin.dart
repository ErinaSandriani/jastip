import 'package:flutter/material.dart';

class TravelerAdminPage
    extends StatelessWidget {

  const TravelerAdminPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Kelola Traveler",
        ),
      ),

      body: const Center(

        child: Text(
          "Data Traveler",
        ),
      ),
    );
  }
}