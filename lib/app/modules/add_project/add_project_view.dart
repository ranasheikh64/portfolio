import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/add_project/add_project_controller.dart';

class AddProjectView extends GetView<AddProjectController> {
  const AddProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Project')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  labelText: 'Project Title',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.techController,
                decoration: const InputDecoration(
                  labelText: 'Technologies (comma separated)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 16),
              // Image Picker
              Obx(() {
                return Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: controller.pickImages,
                      icon: const Icon(Icons.image),
                      label: const Text("Select Images"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (controller.selectedImages.isNotEmpty)
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.image, color: Colors.grey),
                                  // In web/desktop, we can't easily show FileImage from XFile path directly without some work or cross_file_image.
                                  // For now just showing icon to indicate selection.
                                  // If we want to show image, we might need Image.network(file.path) for web or Image.file(File(file.path)) for mobile.
                                  // Keeping it simple since environment is Windows (File should work but XFile abstraction varies).
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        controller.removeImage(index),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                  ],
                );
              }),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.saveProject,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Save Project'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
