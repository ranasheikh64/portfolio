import 'package:flutter/material.dart';
import 'dart:ui'; // For ImageFilter
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/app/data/services/auth_service.dart'
    as portfolio; // Alias to prevent naming collision if any
import 'package:portfolio/app/modules/about/about_view.dart';
import 'package:portfolio/app/modules/contact/contact_view.dart';
import 'package:portfolio/app/modules/cv_templates/cv_templates_view.dart';
import 'package:portfolio/app/modules/dashboard/dashboard_controller.dart';
import 'package:portfolio/app/modules/home/home_view.dart';
import 'package:portfolio/app/modules/projects/projects_view.dart';
import 'package:portfolio/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title)),
        centerTitle: true,
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            HomeView(),
            AboutView(),
            ProjectsView(),
            CvTemplatesView(),
            ContactView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.tabIndex.value,
          onDestinationSelected: controller.changeTabIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.person),
              label: 'About',
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.layers_alt),
              label: 'Projects',
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.doc_text),
              label: 'CV Builder',
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.envelope),
              label: 'Contact',
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Portfolio Access"),
              accountEmail: const Text("Welcome Guest"),
              currentAccountPicture: GestureDetector(
                onLongPress: () {
                  Get.back(); // Close drawer
                  _showSecretLoginDialog(context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    CupertinoIcons.person_circle,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.gear),
              title: const Text('Settings'),
              onTap: () {
                Get.back(); // Close drawer
                Get.toNamed(Routes.SETTINGS);
              },
            ),
            // Admin Login button removed - Secret Access Only!////////
          ],
        ),
      ),
    );
  }

  void _showSecretLoginDialog(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final authService = Get.find<portfolio.AuthService>();

    // Simple local state for validation animation
    var isError = false.obs;

    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.transparent,
          child: FadeInUp(
            duration: const Duration(milliseconds: 400),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 40,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Admin Access",
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Email Field
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintText: "Admin Email",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outlined),
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => ElevatedButton(
                        onPressed: () async {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            isError.value = true;
                            Future.delayed(
                              const Duration(milliseconds: 500),
                              () => isError.value = false,
                            );
                            return;
                          }

                          await authService.login(
                            emailController.text,
                            passwordController.text,
                          );
                          // Start loading or check result
                          // For now assuming Auth service handles state.
                          // We check if authenticated.
                          if (authService.isAuthenticated.value) {
                            Get.back(); // Close dialog
                            Get.snackbar(
                              "Welcome Back",
                              "Admin access granted.",
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          } else {
                            isError.value = true;
                            Get.snackbar(
                              "Access Denied",
                              "Invalid credentials.",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            Future.delayed(
                              const Duration(milliseconds: 500),
                              () => isError.value = false,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isError.value
                              ? Colors.red
                              : Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          isError.value ? "Try Again" : "Unlock",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
