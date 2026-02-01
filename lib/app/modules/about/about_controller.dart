import 'package:get/get.dart';

class AboutController extends GetxController {
  final skills = <SkillCategory>[
    SkillCategory(
      name: "Languages",
      skills: [
        Skill(name: "Dart & Flutter", level: 0.95),
        Skill(name: "Python", level: 0.80),
        Skill(name: "JavaScript", level: 0.70),
      ],
    ),
    SkillCategory(
      name: "Frameworks & Tools",
      skills: [
        Skill(name: "GetX", level: 0.90),
        Skill(name: "Firebase", level: 0.85),
        Skill(name: "Git/GitHub", level: 0.80),
        Skill(name: "Figma", level: 0.75),
      ],
    ),
  ];

  final experience = <ExperienceItem>[
    ExperienceItem(
      title: "Senior Flutter Developer",
      company: "Tech Solutions Inc.",
      duration: "2023 - Present",
      description: "Leading mobile dev team, architecting scaler apps.",
    ),
    ExperienceItem(
      title: "Mobile App Developer",
      company: "Creative Studio",
      duration: "2021 - 2023",
      description: "Developed 10+ apps for various clients.",
    ),
  ];
}

class SkillCategory {
  final String name;
  final List<Skill> skills;
  SkillCategory({required this.name, required this.skills});
}

class Skill {
  final String name;
  final double level; // 0.0 to 1.0
  Skill({required this.name, required this.level});
}

class ExperienceItem {
  final String title;
  final String company;
  final String duration;
  final String description;
  ExperienceItem({
    required this.title,
    required this.company,
    required this.duration,
    required this.description,
  });
}
