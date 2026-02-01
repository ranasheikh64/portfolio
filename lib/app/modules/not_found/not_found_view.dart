import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page Not Found")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text("Oops! The page you are looking for does not exist."),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.offAllNamed('/home'),
              child: const Text("Go Home"),
            ),
          ],
        ),
      ),
    );
  }
}
