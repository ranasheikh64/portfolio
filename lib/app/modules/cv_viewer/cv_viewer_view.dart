import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:portfolio/app/data/models/cv/cv_model.dart';
import 'package:portfolio/app/data/services/cv_pdf_generator.dart';

class CvViewerView extends StatelessWidget {
  const CvViewerView({super.key});

  @override
  Widget build(BuildContext context) {
    // Expect CV object passed as argument, e.g. from Editor or List
    // If null, mock one for testing
    final CV cv = Get.arguments is CV ? Get.arguments as CV : _getMockCv();

    return Scaffold(
      appBar: AppBar(title: Text('${cv.title} Preview')),
      body: PdfPreview(
        build: (format) => CvPdfGenerator.generate(cv),
        canDebug: false,
      ),
    );
  }

  CV _getMockCv() {
    return CV(
      id: 'mock',
      title: 'My Resume',
      templateId: 'modern',
      personalInfo: PersonalInfo(
        name: 'John Doe',
        email: 'john@example.com',
        phone: '+1 234 567 890',
        summary: 'Experienced developer with a passion for Flutter.',
        location: 'New York, USA',
      ),
      skills: ['Flutter', 'Dart', 'Firebase'],
      experience: [
        Experience(
          company: 'Tech Corp',
          role: 'Senior Dev',
          duration: '2020 - Present',
          description: 'Building awesome apps.',
        ),
      ],
      education: [
        Education(school: 'University of Tech', degree: 'BSc CS', year: '2019'),
      ],
    );
  }
}
