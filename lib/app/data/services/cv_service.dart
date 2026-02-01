import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:portfolio/app/data/models/cv/cv_model.dart';

class CvService extends GetxService {
  final _supabase = Supabase.instance.client;
  var myCvs = <CV>[].obs;
  var selectedTemplate = 'classic'.obs;

  Future<CvService> init() async {
    fetchCvs();
    return this;
  }

  Future<void> fetchCvs() async {
    try {
      final response = await _supabase
          .from('cvs')
          .select()
          .order('created_at', ascending: false);
      final data = response as List<dynamic>;
      myCvs.value = data.map((json) => CV.fromSupabase(json)).toList();
    } catch (e) {
      print("Error fetching CVs: $e");
    }
  }

  Future<void> saveCv(CV cv) async {
    try {
      if (cv.id.isEmpty || cv.id == 'new') {
        // Insert
        final response = await _supabase
            .from('cvs')
            .insert(cv.toSupabase())
            .select()
            .single();
        final newCv = CV.fromSupabase(response);
        myCvs.insert(0, newCv);
      } else {
        // Update
        await _supabase.from('cvs').update(cv.toSupabase()).eq('id', cv.id);
        int index = myCvs.indexWhere((e) => e.id == cv.id);
        if (index != -1) {
          myCvs[index] =
              cv; // Note: local object might need updating with new ID if it was new, but Logic here assumes known ID for update
        }
      }
      Get.snackbar("Success", "CV Saved");
    } catch (e) {
      Get.snackbar("Error", "Failed to save CV: $e");
    }
  }

  Future<void> deleteCv(String id) async {
    try {
      await _supabase.from('cvs').delete().eq('id', id);
      myCvs.removeWhere((cv) => cv.id == id);
    } catch (e) {
      Get.snackbar("Error", "Failed to delete CV: $e");
    }
  }
}
