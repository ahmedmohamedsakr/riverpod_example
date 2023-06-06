import 'package:go_router/go_router.dart';
import 'package:riverpod_example/main.dart';
import 'package:riverpod_example/views/combining_provider_view.dart';
import 'package:riverpod_example/views/future_provider_view.dart';

class Routes {
  static const String homeView = '/';
  static const String combiningProviderView = '/combiningProviderScreen';
  static const String futureProviderView = '/futureProviderScreen';
}

final GoRouter goRouter = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: Routes.homeView,
      builder: (context, state) => const HomeView(),
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
  ],
);
