import 'package:go_router/go_router.dart';
import 'package:riverpod_example/main.dart';
import 'package:riverpod_example/views/a.dart';
import 'package:riverpod_example/views/b.dart';
import 'package:riverpod_example/views/c.dart';
import 'package:riverpod_example/views/combining_provider_view.dart';
import 'package:riverpod_example/views/future_provider_view.dart';

class Routes {
  static const String homeView = '/';
  static const String combiningProviderView = '/combiningProviderScreen';
  static const String futureProviderView = '/futureProviderScreen';
  static const String a = '/AScreen';
  static const String b = '/BScreen';
  static const String c = '/CScreen';
}

final GoRouter goRouter = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: Routes.homeView,
      builder: (context, state) => HomeView(),
      routes: [
        GoRoute(
          path: Routes.combiningProviderView.substring(1),
          builder: (context, state) => const CombiningProviderView(),
        ),
        GoRoute(
          path: Routes.futureProviderView.substring(1),
          builder: (context, state) => const FutureProviderView(),
        ),
      ],
    ),
    GoRoute(
      path: Routes.a,
      builder: (context, state) => const A(),
      routes: [
        GoRoute(
          path: Routes.b.substring(1),
          builder: (context, state) => const B(),
        ),
        GoRoute(
          path: Routes.c.substring(1),
          builder: (context, state) => const C(),
        ),
      ],
    ),
  ],
);
