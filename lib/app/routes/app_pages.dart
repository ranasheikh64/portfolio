import 'package:get/get.dart';
import 'package:portfolio/app/modules/home/home_binding.dart';
import 'package:portfolio/app/modules/home/home_view.dart';
import 'package:portfolio/app/modules/splash/splash_binding.dart';
import 'package:portfolio/app/modules/splash/splash_view.dart';
import 'package:portfolio/app/modules/dashboard/dashboard_binding.dart';
import 'package:portfolio/app/modules/dashboard/dashboard_view.dart';
import 'package:portfolio/app/modules/project_details/project_details_view.dart';
import 'package:portfolio/app/modules/settings/settings_view.dart';
import 'package:portfolio/app/modules/settings/settings_controller.dart';
import 'package:portfolio/app/modules/cv_viewer/cv_viewer_view.dart';
// Admin Imports
import 'package:portfolio/app/modules/login/login_view.dart';
import 'package:portfolio/app/modules/login/login_controller.dart';
import 'package:portfolio/app/modules/admin_dashboard/admin_dashboard_view.dart';
import 'package:portfolio/app/modules/admin_dashboard/admin_dashboard_controller.dart';
import 'package:portfolio/app/modules/manage_projects/manage_projects_view.dart';
import 'package:portfolio/app/modules/manage_projects/manage_projects_controller.dart';
import 'package:portfolio/app/modules/add_project/add_project_view.dart';
import 'package:portfolio/app/modules/add_project/add_project_controller.dart';
import 'package:portfolio/app/modules/messages/messages_view.dart';
import 'package:portfolio/app/modules/messages/messages_controller.dart';
import 'package:portfolio/app/modules/edit_profile/edit_profile_view.dart';
import 'package:portfolio/app/modules/cv_templates/cv_templates_view.dart';
import 'package:portfolio/app/modules/cv_editor/cv_editor_view.dart';
import 'package:portfolio/app/modules/cv_editor/cv_editor_controller.dart';
import 'package:portfolio/app/modules/not_found/not_found_view.dart';
import 'package:portfolio/app/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final unknownRoute = GetPage(
    name: '/not-found',
    page: () => const NotFoundView(),
  );

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.PROJECT_DETAILS,
      page: () => const ProjectDetailsView(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),
    GetPage(
      name: Routes.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: BindingsBuilder(() {
        Get.put(AdminDashboardController());
      }),
    ),
    GetPage(
      name: Routes.MANAGE_PROJECTS,
      page: () => const ManageProjectsView(),
      binding: BindingsBuilder(() {
        Get.put(ManageProjectsController());
      }),
    ),
    GetPage(
      name: Routes.ADD_PROJECT,
      page: () => const AddProjectView(),
      binding: BindingsBuilder(() {
        Get.put(AddProjectController());
      }),
    ),
    GetPage(
      name: Routes.MESSAGES,
      page: () => const MessagesView(),
      binding: BindingsBuilder((){
        Get.put(MessagesController());
      })
    ),
    GetPage(name: Routes.EDIT_PROFILE, page: () => const EditProfileView()),
    GetPage(name: Routes.CV_TEMPLATES, page: () => const CvTemplatesView()),
    GetPage(
      name: Routes.CV_EDITOR,
      page: () => const CvEditorView(),
      binding: BindingsBuilder(() {
        Get.put(CvEditorController());
      }),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: BindingsBuilder(() {
        Get.put(SettingsController());
      }),
    ),
    GetPage(name: Routes.CV, page: () => const CvViewerView()),
  ];
}

// Re-export _Paths via Routes for convenience in binding if needed,
// strictly speaking _Paths is private but Routes exposes the constants.
// For GetPage name, we need the string value.
// Adjusting Routes to expose values directly or share _Paths.
// Actually, standard pattern:
// Routes.HOME -> '/home'
// So in AppPages, use Routes.HOME
