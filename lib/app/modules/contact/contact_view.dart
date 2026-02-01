import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/app/modules/contact/contact_controller.dart';
import 'package:flutter/cupertino.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  "Get in Touch",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Have a project in mind or want to hire me? Send me a message!",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),

                // Name
                TextFormField(
                  controller: controller.nameController,
                  decoration: _inputDecoration(
                    context,
                    "Your Name",
                    CupertinoIcons.person,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Name is required" : null,
                ),
                const SizedBox(height: 20),

                // Email
                TextFormField(
                  controller: controller.emailController,
                  decoration: _inputDecoration(
                    context,
                    "Email Address",
                    CupertinoIcons.mail,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      !GetUtils.isEmail(value!) ? "Enter a valid email" : null,
                ),
                const SizedBox(height: 20),

                // Message
                TextFormField(
                  controller: controller.messageController,
                  decoration: _inputDecoration(
                    context,
                    "Message",
                    CupertinoIcons.chat_bubble_text,
                  ).copyWith(alignLabelWithHint: true),
                  maxLines: 5,
                  validator: (value) =>
                      value!.isEmpty ? "Message is required" : null,
                ),
                const SizedBox(height: 40),

                // Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.sendMessage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Send Message",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Contact Info
                _buildContactInfoItem(
                  context,
                  CupertinoIcons.mail,
                  "contact@example.com",
                ),
                _buildContactInfoItem(
                  context,
                  CupertinoIcons.phone,
                  "+123 456 7890",
                ),
                _buildContactInfoItem(
                  context,
                  CupertinoIcons.location,
                  "New York, USA",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context,
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  Widget _buildContactInfoItem(
    BuildContext context,
    IconData icon,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
