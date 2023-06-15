import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_example/core/app_route.dart';
import 'package:riverpod_example/core/log_printer.dart';

void main() {
  print('inside main');
  Logger.level = Level.debug;
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Logger logger = getLogger(className: 'MyApp');

  @override
  Widget build(BuildContext context) {
    // logger.
    logger.d('inside MyApp');
    // print('inside My app');
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
  HomeView({super.key});
  final Logger logger = getLogger(className: 'Home View');

  @override
  Widget build(BuildContext context) {
    logger.d('inside Home view');
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
              onPressed: () {
                context.go(
                  Routes.futureProviderView,
                );
              },
              color: Colors.blueGrey,
              child: const Text('Future provider screen'),
            ),
            MaterialButton(
              onPressed: () => context.go(Routes.combiningProviderView),
              color: Colors.indigo,
              child: const Text('combining provider screen'),
            ),
            MaterialButton(
              onPressed: () {
                try {
                  context.go(Routes.a);
                } catch (e) {
                  logger.e(
                      'navigation error: ${e.toString()} - navigating to A screen from HomeView screen.');
                }
              },
              color: Colors.indigo,
              child: const Text('A screen'),
            ),
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
