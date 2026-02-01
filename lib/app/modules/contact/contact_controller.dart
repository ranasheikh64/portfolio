import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContactController extends GetxController {
  final _supabase = Supabase.instance.client;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  var isLoading = false.obs;

  void sendMessage() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        await _supabase.from('messages').insert({
          'sender_name': nameController.text,
          'content': messageController
              .text, // Assuming email is part of content or schema needs update
          'created_at': DateTime.now().toIso8601String(),
          'is_read': false,
        });

        Get.snackbar(
          "Success",
          "Your message has been sent successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
        );

        // Reset form
        nameController.clear();
        emailController.clear();
        messageController.clear();
      } catch (e) {
        Get.snackbar("Error", "Failed to send message: $e");
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
