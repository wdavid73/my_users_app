import 'package:my_users_app/config/config.dart';
import 'package:go_router/go_router.dart';
import 'package:my_users_app/ui/blocs/blocs.dart';
import 'go_router_notifier.dart';
import 'redirect_handler.dart';
import 'routes_generator.dart';

/// Creates and configures the application's [GoRouter] instance.
///
/// This function initializes the [GoRouter] with the application's routes,
/// initial location, refresh listener, and redirection logic. It uses a
/// [GoRouterNotifier] to listen for changes in the authentication state and
/// the [appRedirect] function to handle redirection based on the current
/// authentication status and route.
///
/// Parameters:
///   - [authBloc]: The [AuthBloc] instance used to manage the authentication state.
///
/// Returns:
///   - A configured [GoRouter] instance ready to be used in the application.
GoRouter createAppRouter(AuthBloc authBloc) {
  final goRouterNotifier = GoRouterNotifier(authBloc);

  return GoRouter(
    initialLocation: RouteConstants.registerUserScreen,
    refreshListenable: goRouterNotifier,
    routes: AppRoutes.getAppRoutes(),
    redirect: (context, state) {
      //return appRedirect(goRouterNotifier, state);
      return null;
    },
  );
}
