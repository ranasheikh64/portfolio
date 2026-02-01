import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:portfolio/app/data/models/project.dart';

class ManageProjectsController extends GetxController {
  final _supabase = Supabase.instance.client;
  var projects = <Project>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    try {
      isLoading.value = true;
      final response = await _supabase
          .from('projects')
          .select()
          .order('created_at', ascending: false);
      final data = response as List<dynamic>;
      projects.value = data.map((json) => Project.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch projects: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProject(String id) async {
    try {
      await _supabase.from('projects').delete().eq('id', id);
      projects.removeWhere((p) => p.id == id);
      Get.snackbar("Success", "Project deleted");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete: $e");
    }
  }
}
