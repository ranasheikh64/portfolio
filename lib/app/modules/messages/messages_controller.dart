import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessagesController extends GetxController {
  final _supabase = Supabase.instance.client;
  var messages = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {
      isLoading.value = true;
      final response = await _supabase
          .from('messages')
          .select()
          .order('created_at', ascending: false);
      messages.value = List<Map<String, dynamic>>.from(response);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch messages: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await _supabase.from('messages').update({'is_read': true}).eq('id', id);
      fetchMessages(); // Refresh list or update locally
    } catch (e) {
      Get.snackbar("Error", "Failed to update message status");
    }
  }
}
