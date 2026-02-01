import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart'; // ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/app/modules/home/home_controller.dart';
import 'package:portfolio/app/modules/dashboard/dashboard_controller.dart';
// import 'package:portfolio/app/modules/projects/projects_controller.dart'; // To navigate to projects tab if needed
import 'package:portfolio/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
// import 'package:url_launcher/url_launcher.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Modern Hero Section
            _buildHeroSection(context),
            // 2. Value Proposition Grid
            _buildFeaturesSection(context),
            // 3. CTA
            _buildCTASection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //     colors: [
      //       Theme.of(context).scaffoldBackgroundColor,
      //       Theme.of(context).primaryColor.withValues(alpha: 0.05),
      //     ],
      //   ),
      // ), // Simplistic gradient, keeping clean
      child: Column(
        children: [
          FadeInDown(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.purple.shade400],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 65,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(
                  'assets/images/profile_placeholder.png',
                ),
                child: Icon(Icons.person, size: 60, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 30),
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: Text(
              "Crafting Digital Experiences",
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                height: 1.1,
                letterSpacing: -1,
              ),
            ),
          ),
          const SizedBox(height: 16),
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            child: Text(
              "Hi, I'm Rana Sheikh. A Flutter Expert building high-performance apps for mobile & web.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 40),
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Projects
                    try {
                      final DashboardController dashboard =
                          Get.find<DashboardController>();
                      dashboard.changeTabIndex(2);
                    } catch (e) {}
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black.withValues(alpha: 0.3),
                  ),
                  child: const Text(
                    "View My Work",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    // Navigate to Contact
                    try {
                      final DashboardController dashboard =
                          Get.find<DashboardController>();
                      dashboard.changeTabIndex(4); // Contact is index 4 now
                    } catch (e) {}
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 18,
                    ),
                    side: const BorderSide(color: Colors.black, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Contact Me",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: Colors.grey[50],
      child: Column(
        children: [
          FadeInUp(
            child: Text(
              "Why Work With Me?",
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _FeatureCard(
                icon: Icons.rocket_launch,
                title: "Fast Performance",
                description:
                    "60fps animations and optimized logic for smooth user experiences.",
              ),
              _FeatureCard(
                icon: Icons.devices,
                title: "Cross-Platform",
                description:
                    "One codebase for iOS, Android, and Web. Efficient and consistent.",
              ),
              _FeatureCard(
                icon: Icons.design_services,
                title: "Pixel Perfect",
                description:
                    "Attention to detail in every pixel, ensuring high-fidelity implementation.",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Ready to start your project?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Let's turn your idea into a reality.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Create Account / CV Builder call to action for SaaS feel
              Get.toNamed(Routes.LOGIN);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Create Your Account",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue, size: 30),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(color: Colors.grey[600], height: 1.5),
          ),
        ],
      ),
    );
  }
}
