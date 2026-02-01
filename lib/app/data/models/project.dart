class Project {
  final String id;
  final String title;
  final String category; // e.g., "Mobile", "Web"
  final List<String> imageUrls;
  final List<String> technologies;
  final String date;
  final String description;

  Project({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrls,
    required this.technologies,
    required this.date,
    required this.description,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      imageUrls: List<String>.from(json['image_urls'] ?? []),
      technologies: List<String>.from(json['technologies'] ?? []),
      date: json['date'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'image_urls': imageUrls,
      'technologies': technologies,
      'date': date,
      'description': description,
    };
  }
}
