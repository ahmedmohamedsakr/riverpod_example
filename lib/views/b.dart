import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_example/core/app_route.dart';

class B extends StatelessWidget {
  const B({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Page B'),
          MaterialButton(
            onPressed: () {
              context.push(
                Routes.c,
              );
            },
            color: Colors.blueGrey,
            child: const Text('c screen'),
          ),
        ],
      )),
    );
  }
}
