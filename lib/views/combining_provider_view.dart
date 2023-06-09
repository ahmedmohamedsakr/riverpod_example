import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

ChangeNotifierProvider<CountryNotifier> countryProvider =
    ChangeNotifierProvider((ref) => CountryNotifier());

class CountryNotifier extends ChangeNotifier {
  String country = 'Egypt';

  void updateCountry(String country) {
    this.country = country;
    notifyListeners();
  }
}

var weatherProvider = StateProvider((ref) {
  var country = ref.watch(countryProvider).country;
  return country == 'Egypt'
      ? 36
      : country == 'Saudi arabia'
          ? 40
          : 33;
});

class CombiningProviderView extends StatelessWidget {
  const CombiningProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) => DropdownButton(
                value: ref.watch(countryProvider).country,
                items: const [
                  DropdownMenuItem(
                    value: 'Egypt',
                    child: Text('Egypt'),
                  ),
                  DropdownMenuItem(
                    value: 'Saudi arabia',
                    child: Text('Saudi arabia'),
                  ),
                  DropdownMenuItem(
                    value: 'USA',
                    child: Text('USA'),
                  ),
                ],
                onChanged: (value) {
                  print(value);
                  ref
                      .read(countryProvider.notifier)
                      .updateCountry(value.toString());
                },
              ),
            ),
            Consumer(
              builder: (context, ref, child) => Text(
                ref.watch(weatherProvider.notifier).state.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
