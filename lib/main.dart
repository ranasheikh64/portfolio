import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/routes/app_pages.dart';
import 'package:portfolio/app/theme/app_theme.dart';
import 'package:portfolio/app/data/services/auth_service.dart';
import 'package:portfolio/app/data/services/cv_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nrkffynvdktvkjbqzjyz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ya2ZmeW52ZGt0dmtqYnF6anl6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk5NDY1NTQsImV4cCI6MjA4NTUyMjU1NH0.xF8ZeoT3pdNEstdtz0geHOshTQ2fJT4rIgqJNkklahY',
  );

  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => CvService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      unknownRoute: AppPages.unknownRoute,
    );
  }
}
