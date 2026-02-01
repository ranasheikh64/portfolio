import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/data/models/cv/cv_model.dart';
import 'package:portfolio/app/data/services/cv_service.dart';
import 'package:portfolio/app/modules/cv_viewer/cv_viewer_view.dart';
import 'package:portfolio/app/routes/app_routes.dart';

class CvTemplatesView extends GetView<CvService> {
  const CvTemplatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Template')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8, // Adjust for taller cards with buttons
        children: [
          _buildTemplateCard(context, 'Classic', 'classic', Colors.grey),
          _buildTemplateCard(context, 'Modern', 'modern', Colors.blue),
          _buildTemplateCard(context, 'Creative', 'creative', Colors.orange),
          _buildTemplateCard(context, 'Minimalist', 'minimalist', Colors.teal),
          _buildTemplateCard(context, 'Tech', 'tech', const Color(0xFF212121)),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(
    BuildContext context,
    String title,
    String id,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description, size: 40, color: color),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _previewTemplate(id),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 36),
                    ),
                    child: const Text('Preview'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.selectedTemplate.value = id;
                      Get.toNamed(Routes.CV_EDITOR);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 36),
                    ),
                    child: const Text('Select'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _previewTemplate(String templateId) {
    final mockCv = CV(
      id: 'preview',
      title: 'Preview',
      templateId: templateId,
      personalInfo: PersonalInfo(
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '+1 234 567 8900',
        role: 'Software Engineer',
        location: 'San Francisco, CA',
        summary:
            'Experienced software engineer with a passion for building scalable web applications and intuitive user interfaces.',
      ),
      skills: ['Flutter', 'Dart', 'React', 'Node.js', 'SQL', 'Git'],
      experience: [
        Experience(
          company: 'Tech Solutions Inc.',
          role: 'Senior Developer',
          duration: '2020 - Present',
          description:
              'Leading a team of developers to build cross-platform mobile apps.',
        ),
        Experience(
          company: 'Web Corp',
          role: 'Web Developer',
          duration: '2018 - 2020',
          description:
              'Developed and maintained company website and internal tools.',
        ),
      ],
      education: [
        Education(
          school: 'University of Technology',
          degree: 'B.S. Computer Science',
          year: '2018',
        ),
      ],
    );

    Get.to(() => const CvViewerView(), arguments: mockCv);
  }
}
