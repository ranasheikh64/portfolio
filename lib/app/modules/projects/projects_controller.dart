import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:portfolio/app/data/models/project.dart';

class ProjectsController extends GetxController {
  final _supabase = Supabase.instance.client;
  var allProjects = <Project>[].obs;
  var filteredProjects = <Project>[].obs;
  var isLoading = true.obs;

  var selectedCategory = 'All'.obs;
  var searchQuery = ''.obs;

  final categories = ['All', 'Mobile App', 'Web', 'Desktop'];

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
      allProjects.value = data.map((json) => Project.fromJson(json)).toList();
      filteredProjects.value = allProjects;
    } catch (e) {
      print('Error fetching projects: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterProjects(String category) {
    selectedCategory.value = category;
    _applyFilters();
  }

  void searchProjects(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  void _applyFilters() {
    List<Project> results = allProjects;

    // Category Filter
    if (selectedCategory.value != 'All') {
      results = results
          .where((p) => p.category == selectedCategory.value)
          .toList();
    }

    // Search Filter
    if (searchQuery.value.isNotEmpty) {
      results = results
          .where(
            (p) =>
                p.title.toLowerCase().contains(
                  searchQuery.value.toLowerCase(),
                ) ||
                p.technologies.any(
                  (t) =>
                      t.toLowerCase().contains(searchQuery.value.toLowerCase()),
                ),
          )
          .toList();
    }

    filteredProjects.value = results;
  }
}
