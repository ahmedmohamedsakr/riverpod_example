import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_example/core/app_route.dart';

class C extends StatelessWidget {
  const C({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Page C'),
          MaterialButton(
            onPressed: () {
              context.push(
                Routes.a,
              );
            },
            color: Colors.blueGrey,
            child: const Text('A screen'),
          ),
        ],
      )),
    );
  }
}
