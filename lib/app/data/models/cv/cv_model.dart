class CV {
  String id;
  String title; // e.g., "Software Engineer Resume"
  String templateId;
  PersonalInfo personalInfo;
  List<Education> education;
  List<Experience> experience;
  List<String> skills;
  List<Language> languages;
  List<Certification> certifications;

  CV({
    required this.id,
    required this.title,
    required this.templateId,
    required this.personalInfo,
    this.education = const [],
    this.experience = const [],
    this.skills = const [],
    this.languages = const [],
    this.certifications = const [],
  });

  factory CV.fromSupabase(Map<String, dynamic> row) {
    final data = row['data'] as Map<String, dynamic>;
    return CV(
      id: row['id'],
      title: row['title'] ?? '',
      templateId: row['template_id'] ?? '',
      personalInfo: PersonalInfo.fromJson(data['personalInfo'] ?? {}),
      education:
          (data['education'] as List?)
              ?.map((e) => Education.fromJson(e))
              .toList() ??
          [],
      experience:
          (data['experience'] as List?)
              ?.map((e) => Experience.fromJson(e))
              .toList() ??
          [],
      skills: List<String>.from(data['skills'] ?? []),
      languages:
          (data['languages'] as List?)
              ?.map((e) => Language.fromJson(e))
              .toList() ??
          [],
      certifications:
          (data['certifications'] as List?)
              ?.map((e) => Certification.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toSupabase() {
    return {
      'title': title,
      'template_id': templateId,
      'data': {
        'personalInfo': personalInfo.toJson(),
        'education': education.map((e) => e.toJson()).toList(),
        'experience': experience.map((e) => e.toJson()).toList(),
        'skills': skills,
        'languages': languages.map((e) => e.toJson()).toList(),
        'certifications': certifications.map((e) => e.toJson()).toList(),
      },
    };
  }
}

class PersonalInfo {
  String name;
  String email;
  String phone;
  String role; // Added role field
  String summary;
  String linkedin;
  String website;
  String location;

  PersonalInfo({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.role = '',
    this.summary = '',
    this.linkedin = '',
    this.website = '',
    this.location = '',
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      summary: json['summary'] ?? '',
      linkedin: json['linkedin'] ?? '',
      website: json['website'] ?? '',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'summary': summary,
      'linkedin': linkedin,
      'website': website,
      'location': location,
    };
  }
}

class Education {
  String school;
  String degree;
  String year;

  Education({this.school = '', this.degree = '', this.year = ''});

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      school: json['school'] ?? '',
      degree: json['degree'] ?? '',
      year: json['year'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'school': school, 'degree': degree, 'year': year};
  }
}

class Experience {
  String company;
  String role;
  String duration;
  String description;

  Experience({
    this.company = '',
    this.role = '',
    this.duration = '',
    this.description = '',
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      company: json['company'] ?? '',
      role: json['role'] ?? '',
      duration: json['duration'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'role': role,
      'duration': duration,
      'description': description,
    };
  }
}

class Language {
  String language;
  String proficiency; // Basic, Intermediate, Fluent, Native

  Language({this.language = '', this.proficiency = ''});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      language: json['language'] ?? '',
      proficiency: json['proficiency'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'language': language, 'proficiency': proficiency};
  }
}

class Certification {
  String name;
  String issuer;
  String date;

  Certification({this.name = '', this.issuer = '', this.date = ''});

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      name: json['name'] ?? '',
      issuer: json['issuer'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'issuer': issuer, 'date': date};
  }
}
