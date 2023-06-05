import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Riverpod(keepAlive: true)
var futureProvider = FutureProvider.autoDispose<String>((ref) => fetchData(ref));

Future<String> fetchData(AutoDisposeFutureProviderRef ref) async {
  var response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  var data = jsonDecode(response.body);
  ref.onDispose(() {
    print('future provider is disposed');
  });
  return data[0]['body'];
}

class FutureProviderScreen extends StatelessWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          print('build future provider screen');
          return Center(
            child: ref.watch(futureProvider).when(
                  data: (String value) => Text(value),
                  error: (error, stack) => const Text('error'),
                  loading: () => const CircularProgressIndicator.adaptive(),
                ),
          );
        },
      ),
    );
  }
}
