// ignore_for_file: constant_identifier_names

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const SPLASH = _Paths.SPLASH;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const PROJECT_DETAILS = _Paths.PROJECT_DETAILS;
  static const SETTINGS = _Paths.SETTINGS;
  static const CV = _Paths.CV;
  static const LOGIN = _Paths.LOGIN;
  static const ADMIN_DASHBOARD = _Paths.ADMIN_DASHBOARD;
  static const MANAGE_PROJECTS = _Paths.MANAGE_PROJECTS;
  static const ADD_PROJECT = _Paths.ADD_PROJECT;
  static const MESSAGES = _Paths.MESSAGES;
  static const EDIT_PROFILE = _Paths.EDIT_PROFILE;
  static const CV_TEMPLATES = _Paths.CV_TEMPLATES;
  static const CV_EDITOR = _Paths.CV_EDITOR;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const SPLASH = '/splash';
  static const DASHBOARD = '/dashboard';
  static const PROJECT_DETAILS = '/project-details';
  static const SETTINGS = '/settings';
  static const CV = '/cv';
  static const LOGIN = '/login';
  static const ADMIN_DASHBOARD = '/admin-dashboard';
  static const MANAGE_PROJECTS = '/manage-projects';
  static const ADD_PROJECT = '/add-project';
  static const MESSAGES = '/messages';
  static const EDIT_PROFILE = '/edit-profile';
  static const CV_TEMPLATES = '/cv-templates';
  static const CV_EDITOR = '/cv-editor';
}
