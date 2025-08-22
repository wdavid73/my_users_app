import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_users_app/ui/screens/screens.dart';
import 'routes_constants.dart';
import 'routes_transitions.dart';

/// A utility class that defines the application's route paths and generates the
/// [GoRouter] route configuration.
///
/// This class provides constants for each route path and a method to generate
/// the list of [RouteBase] objects used by [GoRouter].
class AppRoutes {
  /// Generates the list of [RouteBase] objects for the application.
  ///
  /// This method defines the route hierarchy and associates each route path
  /// with its corresponding screen or view. It also defines nested routes
  /// for the widgets screen.
  ///
  /// Returns:
  ///   - A [List] of [RouteBase] objects representing the application's routes.
  static List<RouteBase> getAppRoutes() {
    return [
      ///* USER SCREENS
      GoRoute(
        path: RouteConstants.registerUserScreen,
        name: "register_user",
        pageBuilder: (_, __) => _transitionPage(
          child: const RegisterUserScreen(),
          transitionType: TransitionType.slideLeft,
        ),
      ),

      GoRoute(
        path: RouteConstants.manageAddressScreen,
        name: "manage_address",
        pageBuilder: (_, __) => _transitionPage(
          child: const ManageAddressScreen(),
          transitionType: TransitionType.slideRight,
        ),
      ),

      GoRoute(
        path: RouteConstants.summaryProfile,
        name: "summary",
        pageBuilder: (_, __) => _transitionPage(
          child: const SummaryScreen(),
          transitionType: TransitionType.slideRight,
        ),
      ),

      ///* SPLASH SCREEN
      GoRoute(
        path: RouteConstants.splash,
        name: "splash",
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* HOME ROUTE
      GoRoute(
        path: RouteConstants.home,
        name: "home",
        builder: (context, state) => const HomeScreen(),
      ),

      /// SETTINGS ROUTE
      GoRoute(
        path: RouteConstants.settingsScreen,
        name: "settings",
        /*builder: (context, state) => const SettingsScreen(),*/
        pageBuilder: (_, __) => _transitionPage(
          child: const SettingsScreen(),
          transitionType: TransitionType.slideRight,
        ),
      ),

      ///* AUTH ROUTES
      GoRoute(
        path: RouteConstants.loginScreen,
        name: "login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteConstants.registerScreen,
        name: "register",
        builder: (context, state) => const RegisterScreen(),
      ),
    ];
  }
}

CustomTransitionPage<void> _transitionPage({
  required Widget child,
  TransitionType? transitionType,
}) =>
    TransitionManager.buildCustomTransitionPage(
      child,
      transitionType,
    );
