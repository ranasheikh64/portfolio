import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/admin_dashboard/admin_dashboard_controller.dart';
import 'package:portfolio/app/routes/app_routes.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1E1E2C),
        foregroundColor: Colors.white,
        title: const Text(
          'Admin Console',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.logout,
            tooltip: "Logout",
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D3436),
              ),
            ),
            Text(
              "Overview of your portfolio performance",
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 32),

            // Stats Grid
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildStatCard(
                      context,
                      "Total Views",
                      "12.5K",
                      Icons.trending_up,
                      const Color(0xFF6C5CE7),
                      "+12% this week",
                    ),
                    _buildStatCard(
                      context,
                      "Projects",
                      "14",
                      Icons.layers,
                      const Color(0xFF00CEC9),
                      "2 new added",
                    ),
                    _buildStatCard(
                      context,
                      "Messages",
                      "5",
                      Icons.mail,
                      const Color(0xFFFD79A8),
                      "3 unread",
                    ),
                    _buildStatCard(
                      context,
                      "CV Downloads",
                      "48",
                      Icons.download,
                      const Color(0xFFFAB1A0),
                      "Updated today",
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 48),
            Text(
              "Quick Actions",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D3436),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    context,
                    "Add New Project",
                    Icons.add_circle,
                    Colors.blue,
                    () => Get.toNamed(Routes.ADD_PROJECT),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    context,
                    "View Messages",
                    Icons.message,
                    Colors.orange,
                    () => Get.toNamed(Routes.MESSAGES),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF1E1E2C)),
            accountName: const Text("Admin"),
            accountEmail: const Text("admin@portfolio.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF1E1E2C)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            selected: true,
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text("Manage Projects"),
            onTap: () => Get.toNamed(Routes.MANAGE_PROJECTS),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text("CV Templates"),
            onTap: () => Get.toNamed(Routes.CV_TEMPLATES),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("Profile"),
            onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      width: 150, // Fixed width for wrap, or use Expanded in Row
      height: 140,
      constraints: const BoxConstraints(minWidth: 150),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              // Optional: Trend icon
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
