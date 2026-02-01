import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/data/models/project.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProjectDetailsView extends StatelessWidget {
  const ProjectDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve project from arguments
    final Project project = Get.arguments as Project;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                project.title,
                style: TextStyle(
                  color: Colors.black,
                  shadows: [Shadow(blurRadius: 2, color: Colors.white)],
                ),
              ),
              background: project.imageUrls.isNotEmpty
                  ? CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                      ),
                      items: project.imageUrls.map((url) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Image.network(
                              url,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (ctx, err, stack) =>
                                  const Center(child: Icon(Icons.error)),
                            );
                          },
                        );
                      }).toList(),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 80, color: Colors.grey),
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Technologies
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.technologies
                        .map(
                          (t) => Chip(
                            label: Text(t),
                            backgroundColor: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.1),
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description * 5, // Mocking longer text
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.6),
                  ),
                  const SizedBox(height: 32),

                  // Details Grid
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(context, "Category", project.category),
                        const Divider(),
                        _buildDetailRow(context, "Date", project.date),
                        const Divider(),
                        _buildDetailRow(context, "Client", "Personal Project"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {}, // Launch GitHub
                      icon: const Icon(
                        Icons.code,
                        color: Colors.white,
                      ), // Fixed Icon
                      label: const Text("View Code on GitHub"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {}, // Launch Live Demo
                      icon: const Icon(CupertinoIcons.globe),
                      label: const Text("Live Demo"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Theme.of(context).primaryColor)),
        ],
      ),
    );
  }
}
