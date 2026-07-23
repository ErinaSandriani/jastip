import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/pesanan_viewmodel.dart';
import 'viewmodels/traveler_viewmodel.dart';
import 'viewmodels/dashboard_admin_viewmodel.dart';
import 'viewmodels/profile_viewmodel.dart';
import 'viewmodels/traveler_order_viewmodel.dart';
import 'viewmodels/notification_viewmodel.dart';

import 'views/auth/welcome_page.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) => PesananViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) => TravelerViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) => DashboardAdminViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) => TravelerOrderViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) => NotificationViewModel(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: "Jastip Korea",

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pink,
          ),
          useMaterial3: true,
        ),

        home: const WelcomePage(),
      ),
    );
  }
}