import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/cv_editor/cv_editor_controller.dart';
import 'package:portfolio/app/data/models/cv/cv_model.dart';

class CvEditorView extends GetView<CvEditorController> {
  const CvEditorView({super.key});

  @override
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CV Builder Pro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_upload_outlined, color: Colors.blue),
            onPressed: controller.saveToDatabase,
            tooltip: "Save to Cloud",
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
            onPressed: controller.exportPdf,
            tooltip: "Export Professional PDF",
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TabBar(
              controller: controller.tabController,
              isScrollable: true,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: "Personal Info"),
                Tab(text: "Experience"),
                Tab(text: "Education"),
                Tab(text: "Skills"),
                Tab(text: "Extras"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildPersonalInfoTab(context),
                _buildExperienceTab(context),
                _buildEducationTab(context),
                _buildSkillsTab(context),
                _buildExtrasTab(context), // Languages & Certifications
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper for consistent text fields
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FadeInUp(
        duration: const Duration(milliseconds: 300),
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Basic Information",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildTextField(controller.nameController, "Full Name", Icons.person),
          _buildTextField(
            controller.roleController,
            "Current Job Title",
            Icons.work,
          ),
          _buildTextField(
            controller.emailController,
            "Email Address",
            Icons.email,
          ),
          _buildTextField(
            controller.phoneController,
            "Phone Number",
            Icons.phone,
          ),
          _buildTextField(
            controller.locationController,
            "Location (City, Country)",
            Icons.location_on,
          ),

          const SizedBox(height: 20),
          Text(
            "Online Presence",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller.linkedinController,
            "LinkedIn URL",
            Icons.link,
          ),
          _buildTextField(
            controller.websiteController,
            "Portfolio Website",
            Icons.language,
          ),

          const SizedBox(height: 20),
          Text(
            "Professional Summary",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller.summaryController,
            "Bio / Summary",
            Icons.description,
            maxLines: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceTab(BuildContext context) {
    return _buildListSection(
      context,
      "Work Experience",
      controller.experienceList,
      (Experience exp) => ListTile(
        title: Text(
          exp.role,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${exp.company} • ${exp.duration}"),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.work, color: Colors.blue),
        ),
      ),
      _showAddExperienceDialog,
    );
  }

  Widget _buildEducationTab(BuildContext context) {
    return _buildListSection(
      context,
      "Education History",
      controller.educationList,
      (Education edu) => ListTile(
        title: Text(
          edu.school,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${edu.degree} • ${edu.year}"),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.school, color: Colors.orange),
        ),
      ),
      _showAddEducationDialog,
    );
  }

  Widget _buildSkillsTab(BuildContext context) {
    final skillController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Skills & Expertise",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: skillController,
                  decoration: InputDecoration(
                    labelText: "Add a skill (e.g. Flutter, Project Management)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSubmitted: (val) {
                    controller.addSkill(val);
                    skillController.clear();
                  },
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                  size: 30,
                ),
                onPressed: () {
                  controller.addSkill(skillController.text);
                  skillController.clear();
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.skillsList
                    .map(
                      (skill) => Chip(
                        label: Text(skill),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () => controller.skillsList.remove(skill),
                        backgroundColor: Colors.blue.shade50,
                        labelStyle: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtrasTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Languages Section
          _buildExtrasHeader(
            context,
            "Languages",
            onAdd: () => _showAddLanguageDialog(context),
          ),
          Obx(
            () => Column(
              children: controller.languageList
                  .map(
                    (lang) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(
                          lang.language,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(lang.proficiency),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.grey),
                          onPressed: () => controller.languageList.remove(lang),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(height: 32),

          // Certifications Section
          _buildExtrasHeader(
            context,
            "Certifications",
            onAdd: () => _showAddCertificationDialog(context),
          ),
          Obx(
            () => Column(
              children: controller.certificationList
                  .map(
                    (cert) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(
                          cert.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("${cert.issuer} • ${cert.date}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.grey),
                          onPressed: () =>
                              controller.certificationList.remove(cert),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtrasHeader(
    BuildContext context,
    String title, {
    required VoidCallback onAdd,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add),
          label: const Text("Add"),
        ),
      ],
    );
  }

  // Create a reusable list section for Experience/Education
  Widget _buildListSection<T>(
    BuildContext context,
    String title,
    RxList<T> list,
    Widget Function(T) itemBuilder,
    Function(BuildContext) onAdd,
  ) {
    return Column(
      children: [
        Expanded(
          child: Obx(
            () => list.isEmpty
                ? Center(
                    child: Text(
                      "No $title added yet.",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return FadeInUp(
                        delay: Duration(milliseconds: index * 100),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: itemBuilder(item),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () => list.removeAt(index),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => onAdd(context),
              icon: const Icon(Icons.add),
              label: Text("Add $title"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // DIALOGS
  void _showAddExperienceDialog(BuildContext context) {
    final companyController = TextEditingController();
    final roleController = TextEditingController();
    final durationController = TextEditingController();
    final descController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Experience",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                _buildTextField(roleController, "Role Title", Icons.work),
                _buildTextField(companyController, "Company", Icons.business),
                _buildTextField(
                  durationController,
                  "Duration",
                  Icons.calendar_today,
                ),
                _buildTextField(
                  descController,
                  "Description",
                  Icons.description,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (roleController.text.isNotEmpty) {
                      controller.addExperience(
                        Experience(
                          role: roleController.text,
                          company: companyController.text,
                          duration: durationController.text,
                          description: descController.text,
                        ),
                      );
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Add Experience"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddEducationDialog(BuildContext context) {
    final schoolController = TextEditingController();
    final degreeController = TextEditingController();
    final yearController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Education",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  schoolController,
                  "School / University",
                  Icons.school,
                ),
                _buildTextField(degreeController, "Degree", Icons.emoji_events),
                _buildTextField(yearController, "Year", Icons.calendar_month),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (schoolController.text.isNotEmpty) {
                      controller.addEducation(
                        Education(
                          school: schoolController.text,
                          degree: degreeController.text,
                          year: yearController.text,
                        ),
                      );
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Add Education"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddLanguageDialog(BuildContext context) {
    final langController = TextEditingController();
    final proficiencyController = TextEditingController();

    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Language",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                langController,
                "Language (e.g. English)",
                Icons.language,
              ),
              _buildTextField(
                proficiencyController,
                "Proficiency (e.g. Native, Fluent)",
                Icons.star,
              ),
              ElevatedButton(
                onPressed: () {
                  if (langController.text.isNotEmpty) {
                    controller.addLanguage(
                      Language(
                        language: langController.text,
                        proficiency: proficiencyController.text,
                      ),
                    );
                    Get.back();
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddCertificationDialog(BuildContext context) {
    final nameController = TextEditingController();
    final issuerController = TextEditingController();
    final dateController = TextEditingController();

    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Certification",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                nameController,
                "Certificate Name",
                Icons.verified,
              ),
              _buildTextField(
                issuerController,
                "Issuing Organization",
                Icons.business,
              ),
              _buildTextField(dateController, "Date", Icons.calendar_today),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    controller.addCertification(
                      Certification(
                        name: nameController.text,
                        issuer: issuerController.text,
                        date: dateController.text,
                      ),
                    );
                    Get.back();
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
