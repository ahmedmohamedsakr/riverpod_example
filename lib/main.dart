import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_example/core/app_route.dart';

void main() {
  print('inside main');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('inside My app');
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}

var counterProvider = StateProvider<int>((ref) {
  print('state provider is initialized');
  return 0;
});

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print('inside home view');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                debugPrint('build Text');
                return Text(ref.watch(counterProvider).toString());
              },
            ),
            MaterialButton(
              onPressed: () => context.go(
                Routes.futureProviderView,
              ),
              // onPressed: () => Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const FutureProviderView(),
              //   ),
              // ),
              color: Colors.blueGrey,
              child: const Text('Future provider screen'),
            ),
            MaterialButton(
              onPressed: () => context.go(Routes.combiningProviderView),
              // onPressed: () => Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const CombiningProviderView(),
              //   ),
              // ),
              color: Colors.indigo,
              child: const Text('combining provider screen'),
            ),
            // Consumer(
            //   builder: (context, ref, child) => ref.watch(futureProvider).when(
            //         data: (data) => Text(data),
            //         error: (error, stackTrace) {
            //           debugPrint(error.toString());
            //           return Text(error.toString());
            //         },
            //         loading: () => const CircularProgressIndicator(),
            //       ),
            // )
          ],
        ),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          debugPrint('build FAB');
          return FloatingActionButton(
            onPressed: () {
              ref.read(counterProvider.notifier).state++;
            },
            child: const Icon(
              Icons.add,
            ),
          );
        },
      ),
    );
  }
}

/// - [onDispose], a life-cycle for when a provider is disposed.
/// - [onResume], a life-cycle for when the provider is listened to again.
/// - [onCancel], a life-cycle for when all listeners of a provider are removed.
/// - [onAddListener], for when a listener is added
/// - [onRemoveListener], for when a listener is removed
