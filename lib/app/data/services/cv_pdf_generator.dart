import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:portfolio/app/data/models/cv/cv_model.dart';

class CvPdfGenerator {
  static Future<Uint8List> generate(CV cv) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          switch (cv.templateId) {
            case 'modern':
              return _buildModernTemplate(cv);
            case 'creative':
              return _buildCreativeTemplate(cv);
            case 'minimalist':
              return _buildMinimalistTemplate(cv);
            case 'tech':
              return _buildTechTemplate(cv);
            case 'classic':
            default:
              return _buildClassicTemplate(cv);
          }
        },
      ),
    );

    return pdf.save();
  }

  // --- Classic Template ---
  static List<pw.Widget> _buildClassicTemplate(CV cv) {
    return [
      pw.Header(
        level: 0,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              cv.personalInfo.name,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24),
            ),
            pw.SizedBox(height: 4),
            pw.Text(cv.personalInfo.email),
            pw.Text(cv.personalInfo.phone),
            pw.Text(cv.personalInfo.location),
            if (cv.personalInfo.linkedin.isNotEmpty)
              pw.Text(cv.personalInfo.linkedin),
            if (cv.personalInfo.website.isNotEmpty)
              pw.Text(cv.personalInfo.website),
          ],
        ),
      ),
      if (cv.personalInfo.summary.isNotEmpty) ...[
        pw.SizedBox(height: 10),
        pw.Header(level: 1, child: pw.Text('Professional Summary')),
        pw.Text(cv.personalInfo.summary),
      ],
      if (cv.experience.isNotEmpty) ...[
        pw.SizedBox(height: 10),
        pw.Header(level: 1, child: pw.Text('Experience')),
        ...cv.experience
            .map(
              (e) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        e.company,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(e.duration),
                    ],
                  ),
                  pw.Text(
                    e.role,
                    style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
                  ),
                  pw.Text(e.description),
                  pw.SizedBox(height: 8),
                ],
              ),
            )
            .toList(),
      ],
      if (cv.education.isNotEmpty) ...[
        pw.SizedBox(height: 10),
        pw.Header(level: 1, child: pw.Text('Education')),
        ...cv.education
            .map(
              (e) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        e.school,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(e.year),
                    ],
                  ),
                  pw.Text(e.degree),
                  pw.SizedBox(height: 8),
                ],
              ),
            )
            .toList(),
      ],
      if (cv.skills.isNotEmpty) ...[
        pw.SizedBox(height: 10),
        pw.Header(level: 1, child: pw.Text('Skills')),
        pw.Wrap(
          spacing: 8,
          runSpacing: 4,
          children: cv.skills.map((s) => pw.Text("• $s")).toList(),
        ),
      ],
    ];
  }

  // --- Modern Template ---
  static List<pw.Widget> _buildModernTemplate(CV cv) {
    // Two column layout
    return [
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Sidebar
          pw.Expanded(
            flex: 1,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  cv.personalInfo.name,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 20,
                    color: PdfColors.blue800,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  "Contact",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.Divider(color: PdfColors.grey300),
                pw.Text(cv.personalInfo.email),
                pw.Text(cv.personalInfo.phone),
                pw.Text(cv.personalInfo.location),
                pw.SizedBox(height: 20),

                if (cv.skills.isNotEmpty) ...[
                  pw.Text(
                    "Skills",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.grey700,
                    ),
                  ),
                  pw.Divider(color: PdfColors.grey300),
                  ...cv.skills.map((s) => pw.Text("• $s")),
                  pw.SizedBox(height: 20),
                ],

                if (cv.languages.isNotEmpty) ...[
                  pw.Text(
                    "Languages",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.grey700,
                    ),
                  ),
                  pw.Divider(color: PdfColors.grey300),
                  ...cv.languages.map(
                    (l) => pw.Text("${l.language} - ${l.proficiency}"),
                  ),
                ],
              ],
            ),
          ),
          pw.SizedBox(width: 20),
          // Main Content
          pw.Expanded(
            flex: 2,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (cv.personalInfo.summary.isNotEmpty) ...[
                  pw.Text(
                    "Profile",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16,
                      color: PdfColors.blue800,
                    ),
                  ),
                  pw.Divider(color: PdfColors.blue200),
                  pw.Text(cv.personalInfo.summary),
                  pw.SizedBox(height: 20),
                ],

                if (cv.experience.isNotEmpty) ...[
                  pw.Text(
                    "Experience",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16,
                      color: PdfColors.blue800,
                    ),
                  ),
                  pw.Divider(color: PdfColors.blue200),
                  ...cv.experience
                      .map(
                        (e) => pw.Container(
                          margin: const pw.EdgeInsets.only(bottom: 10),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                e.role,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    e.company,
                                    style: pw.TextStyle(
                                      color: PdfColors.grey700,
                                    ),
                                  ),
                                  pw.Text(
                                    e.duration,
                                    style: pw.TextStyle(
                                      color: PdfColors.grey700,
                                    ),
                                  ),
                                ],
                              ),
                              pw.Text(e.description),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  pw.SizedBox(height: 20),
                ],

                if (cv.education.isNotEmpty) ...[
                  pw.Text(
                    "Education",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 16,
                      color: PdfColors.blue800,
                    ),
                  ),
                  pw.Divider(color: PdfColors.blue200),
                  ...cv.education
                      .map(
                        (e) => pw.Container(
                          margin: const pw.EdgeInsets.only(bottom: 10),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                e.school,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text("${e.degree}, ${e.year}"),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ],
            ),
          ),
        ],
      ),
    ];
  }

  // --- Creative Template ---
  static List<pw.Widget> _buildCreativeTemplate(CV cv) {
    return [
      pw.Container(
        color: PdfColors.orange50,
        padding: const pw.EdgeInsets.all(20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              cv.personalInfo.name.toUpperCase(),
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 30,
                color: PdfColors.orange800,
              ),
            ),
            pw.Text(
              cv.title.toUpperCase(),
              style: pw.TextStyle(letterSpacing: 2, fontSize: 14),
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(cv.personalInfo.email),
                pw.SizedBox(width: 10),
                pw.Text("|"),
                pw.SizedBox(width: 10),
                pw.Text(cv.personalInfo.phone),
              ],
            ),
          ],
        ),
      ),
      pw.SizedBox(height: 20),
      // Creative layout content...
      ..._buildClassicTemplate(cv),
    ];
  }

  // --- Minimalist Template ---
  static List<pw.Widget> _buildMinimalistTemplate(CV cv) {
    return [
      pw.Center(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              cv.personalInfo.name.toUpperCase(),
              style: pw.TextStyle(
                fontSize: 28,
                fontWeight: pw.FontWeight.normal,
                letterSpacing: 4,
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Text(
              cv.personalInfo.role.toUpperCase(),
              style: pw.TextStyle(
                fontSize: 12,
                color: PdfColors.grey600,
                letterSpacing: 2,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Divider(thickness: 0.5, color: PdfColors.grey400),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(cv.personalInfo.email),
                pw.SizedBox(width: 15),
                pw.Text(cv.personalInfo.phone),
                pw.SizedBox(width: 15),
                pw.Text(cv.personalInfo.location),
              ],
            ),
            pw.SizedBox(height: 30),
          ],
        ),
      ),
      // Clean sections
      if (cv.personalInfo.summary.isNotEmpty) ...[
        _buildMinimalHeader("SUMMARY"),
        pw.Text(cv.personalInfo.summary, textAlign: pw.TextAlign.justify),
        pw.SizedBox(height: 20),
      ],
      if (cv.experience.isNotEmpty) ...[
        _buildMinimalHeader("EXPERIENCE"),
        ...cv.experience.map(
          (e) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 15),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(
                  width: 100,
                  child: pw.Text(
                    e.duration,
                    style: const pw.TextStyle(
                      color: PdfColors.grey600,
                      fontSize: 10,
                    ),
                  ),
                ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        e.role,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        e.company,
                        style: const pw.TextStyle(fontSize: 11),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        e.description,
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      if (cv.education.isNotEmpty) ...[
        _buildMinimalHeader("EDUCATION"),
        ...cv.education.map(
          (e) => pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                width: 100,
                child: pw.Text(
                  e.year,
                  style: const pw.TextStyle(
                    color: PdfColors.grey600,
                    fontSize: 10,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      e.school,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(e.degree, style: const pw.TextStyle(fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ];
  }

  static pw.Widget _buildMinimalHeader(String title) {
    return pw.Container(
      alignment: pw.Alignment.centerLeft,
      margin: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          letterSpacing: 2,
          fontSize: 12,
        ),
      ),
    );
  }

  // --- Tech Template ---
  static List<pw.Widget> _buildTechTemplate(CV cv) {
    final codeFont = pw
        .Font.courier(); // Use a monospaced font if available, else standard fallback
    final accent = PdfColors.greenAccent400;
    final bg = PdfColors.grey900;
    final text = PdfColors.white;

    return [
      pw.Container(
        padding: const pw.EdgeInsets.all(20),
        color: bg,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "< ${cv.personalInfo.name} />",
              style: pw.TextStyle(
                font: codeFont,
                color: accent,
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              "// ${cv.title}",
              style: pw.TextStyle(
                font: codeFont,
                color: PdfColors.grey500,
                fontSize: 14,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              "const contact = {",
              style: pw.TextStyle(font: codeFont, color: PdfColors.grey400),
            ),
            pw.Text(
              "  email: '${cv.personalInfo.email}',",
              style: pw.TextStyle(font: codeFont, color: text),
            ),
            pw.Text(
              "  phone: '${cv.personalInfo.phone}',",
              style: pw.TextStyle(font: codeFont, color: text),
            ),
            pw.Text(
              "  location: '${cv.personalInfo.location}'",
              style: pw.TextStyle(font: codeFont, color: text),
            ),
            pw.Text(
              "};",
              style: pw.TextStyle(font: codeFont, color: PdfColors.grey400),
            ),
            pw.SizedBox(height: 20),
          ],
        ),
      ),
      pw.SizedBox(height: 20),
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (cv.skills.isNotEmpty) ...[
              pw.Text(
                "class Skills {",
                style: pw.TextStyle(
                  font: codeFont,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Wrap(
                spacing: 8,
                children: cv.skills
                    .map(
                      (s) => pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.black),
                          borderRadius: pw.BorderRadius.circular(4),
                        ),
                        child: pw.Text(
                          s,
                          style: pw.TextStyle(font: codeFont, fontSize: 10),
                        ),
                      ),
                    )
                    .toList(),
              ),
              pw.Text(
                "}",
                style: pw.TextStyle(
                  font: codeFont,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
            ],
            if (cv.experience.isNotEmpty) ...[
              pw.Text(
                "function Experience() {",
                style: pw.TextStyle(
                  font: codeFont,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              ...cv.experience.map(
                (e) => pw.Container(
                  margin: const pw.EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                    top: 5,
                  ),
                  padding: const pw.EdgeInsets.only(left: 10),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      left: pw.BorderSide(color: PdfColors.grey400),
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "return {",
                        style: pw.TextStyle(
                          font: codeFont,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.Text(
                        "  role: '${e.role}',",
                        style: pw.TextStyle(
                          font: codeFont,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        "  company: '${e.company}',",
                        style: pw.TextStyle(font: codeFont),
                      ),
                      pw.Text(
                        "  period: '${e.duration}',",
                        style: pw.TextStyle(
                          font: codeFont,
                          color: PdfColors.grey600,
                          fontSize: 10,
                        ),
                      ),
                      pw.Text(
                        "  desc: '${e.description}'",
                        style: pw.TextStyle(font: codeFont, fontSize: 10),
                      ),
                      pw.Text(
                        "};",
                        style: pw.TextStyle(
                          font: codeFont,
                          color: PdfColors.grey600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.Text(
                "}",
                style: pw.TextStyle(
                  font: codeFont,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    ];
  }
}
