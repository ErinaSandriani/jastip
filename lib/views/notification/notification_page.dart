import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/notification_viewmodel.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() =>
      _NotificationPageState();
}

class _NotificationPageState
    extends State<NotificationPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      final auth =
          context.read<AuthViewModel>();

      context
          .read<NotificationViewModel>()
          .getNotifications(auth.userId!);

    });
  }

  @override
  Widget build(BuildContext context) {

    final vm =
        context.watch<NotificationViewModel>();

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Notifikasi",
        ),
      ),

      body: vm.isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : vm.notifications.isEmpty

              ? const Center(
                  child: Text(
                    "Belum ada notifikasi",
                  ),
                )

              : ListView.builder(

                  itemCount:
                      vm.notifications.length,

                  itemBuilder:
                      (context, index) {

                    final notif =
                        vm.notifications[index];

                    return ListTile(

                      leading: CircleAvatar(

                        backgroundColor:

                            notif.isRead

                                ? Colors.grey

                                : Colors.red,

                        child: const Icon(

                          Icons.notifications,

                          color: Colors.white,
                        ),
                      ),

                      title: Text(
                        notif.judul,
                      ),

                      subtitle: Text(
                        notif.pesan,
                      ),

                      trailing: Text(
                        notif.createdAt
                            .substring(0, 10),
                      ),
                    );
                  },
                ),
    );
  }
}