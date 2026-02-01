import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/data/services/cv_service.dart';
import 'package:portfolio/app/data/models/cv/cv_model.dart';
import 'package:portfolio/app/data/services/cv_pdf_generator.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class CvEditorController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final cvService = Get.find<CvService>();

  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final summaryController = TextEditingController();

  // New Contact Fields
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final linkedinController = TextEditingController();
  final websiteController = TextEditingController();
  final locationController = TextEditingController();

  // Reactive lists for dynamic sections
  var experienceList = <Experience>[].obs;
  var educationList = <Education>[].obs;
  var skillsList = <String>[].obs;
  var languageList = <Language>[].obs;
  var certificationList = <Certification>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Increase tab length to 5 for Skills/Languages & Certifications
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void addExperience(Experience exp) {
    experienceList.add(exp);
  }

  void removeExperience(int index) {
    experienceList.removeAt(index);
  }

  void addEducation(Education edu) {
    educationList.add(edu);
  }

  void removeEducation(int index) {
    educationList.removeAt(index);
  }

  void addSkill(String skill) {
    if (skill.isNotEmpty) skillsList.add(skill);
  }

  void removeSkill(int index) {
    skillsList.removeAt(index);
  }

  void addLanguage(Language lang) {
    languageList.add(lang);
  }

  void removeLanguage(int index) {
    languageList.removeAt(index);
  }

  void addCertification(Certification cert) {
    certificationList.add(cert);
  }

  void removeCertification(int index) {
    certificationList.removeAt(index);
  }

  void saveToDatabase() {
    final newCv = _createCvFromInput();
    cvService.saveCv(newCv);
    Get.snackbar(
      "Success",
      "CV Saved to Cloud!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  CV _createCvFromInput() {
    return CV(
      id: 'new',
      title: "${nameController.text}'s Professional CV",
      templateId: cvService.selectedTemplate.value,
      personalInfo: PersonalInfo(
        name: nameController.text,
        summary: summaryController.text,
        email: emailController.text,
        phone: phoneController.text,
        linkedin: linkedinController.text,
        website: websiteController.text,
        location: locationController.text,
      ),
      experience: experienceList,
      education: educationList,
      skills: skillsList,
      languages: languageList,
      certifications: certificationList,
    );
  }

  void exportPdf() async {
    final cv = _createCvFromInput();
    final pdfBytes = await CvPdfGenerator.generate(cv);
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }
}
