import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/manage_projects/manage_projects_controller.dart';
import 'package:portfolio/app/routes/app_routes.dart';

class ManageProjectsView extends GetView<ManageProjectsController> {
  const ManageProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Projects'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Get.toNamed(Routes.ADD_PROJECT),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.projects.isEmpty) {
          return const Center(child: Text("No projects yet"));
        }
        return ListView.builder(
          itemCount: controller.projects.length,
          itemBuilder: (context, index) {
            final project = controller.projects[index];
            return ListTile(
              leading: Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
                child: const Icon(Icons.image),
              ),
              title: Text(project.title),
              subtitle: Text(project.category),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
