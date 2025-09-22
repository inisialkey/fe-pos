import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/dependencies_injection.dart';
import 'package:pos/features/features.dart';
import 'package:pos/utils/utils.dart';

enum Routes {
  root('/'),
  splashScreen('/splashscreen'),

  /// Home Page
  home('/home'),
  dashboard('/dashboard'),
  settings('/settings'),

  // Auth Page
  login('/auth/login'),
  register('/auth/register');

  const Routes(this.path);

  final String path;
}

class AppRoute {
  static late BuildContext context;
  static late bool isUnitTest;

  AppRoute.setStream(BuildContext ctx, {bool isTest = false}) {
    context = ctx;
    isUnitTest = isTest;
  }

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.splashScreen.path,
        name: Routes.splashScreen.name,
        builder: (_, state) => SplashScreenPage(),
      ),
      GoRoute(
        path: Routes.root.path,
        name: Routes.root.name,
        redirect: (context, state) => Routes.home.path,
      ),
      GoRoute(
        path: Routes.login.path,
        name: Routes.login.name,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ReloadFormCubit>(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: Routes.register.path,
        name: Routes.register.name,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<RegisterCubit>()),
            BlocProvider(create: (_) => sl<ReloadFormCubit>()),
          ],
          child: const RegisterPage(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => BlocProvider(
          create: (context) => sl<MainCubit>(),
          child: MainPage(child: child),
        ),
        routes: [
          GoRoute(
            path: Routes.home.path,
            name: Routes.home.name,
            builder: (_, state) => const Homepage(),
          ),
          GoRoute(
            path: Routes.settings.path,
            name: Routes.settings.name,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
    initialLocation: Routes.splashScreen.path,
    routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: isUnitTest
        ? null
        //coverage:ignore-start
        : GoRouterRefreshStream([
            context.read<AuthCubit>().stream,
            context.read<LogoutCubit>().stream,
          ]),
    //coverage:ignore-end
    redirect: (_, GoRouterState state) {
      final bool isAllowedPages =
          state.matchedLocation == Routes.login.path ||
          state.matchedLocation == Routes.register.path ||
          state.matchedLocation == Routes.splashScreen.path;

      ///  Check if not login
      ///  if current page is login page we don't need to direct user
      ///  but if not we must direct user to login page
      if (!((MainBoxMixin.mainBox?.get(MainBoxKeys.isLogin.name) as bool?) ??
          false)) {
        return isAllowedPages ? null : Routes.login.path; //coverage:ignore-line
      }

      /// Check if already login and in login page
      /// we should direct user to main page

      if (isAllowedPages &&
          ((MainBoxMixin.mainBox?.get(MainBoxKeys.isLogin.name) as bool?) ??
              false)) {
        return Routes.root.path;
      }

      /// No direct
      return null;
    },
  );
}
