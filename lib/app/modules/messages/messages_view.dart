import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:portfolio/app/modules/messages/messages_controller.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages & Inquiries')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.messages.isEmpty) {
          return const Center(child: Text("No messages yet."));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.messages.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final msg = controller.messages[index];
            return FadeInUp(
              delay: Duration(milliseconds: 100 * index),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    child: Text(
                      (msg['sender_name'] as String)[0].toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    msg['sender_name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      msg['content'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   "${index + 2}h ago", // TODO: Format timestamp
                      //   style: TextStyle(fontSize: 12, color: Colors.grey),
                      // ),
                      if (msg['is_read'] == false)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    controller.markAsRead(msg['id']);
                    Get.defaultDialog(
                      title: "Message from ${msg['sender_name']}",
                      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      middleText: msg['content'],
                      textConfirm: "Reply",
                      textCancel: "Mark as Read",
                      confirmTextColor: Colors.white,
                      onConfirm: () => Get.back(),
                      radius: 12,
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
