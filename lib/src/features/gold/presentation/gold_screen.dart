import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/fake_gold_api.dart';

class GoldScreen extends StatelessWidget {
  const GoldScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final Stream<double> goldPrice = getGoldPriceStream();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 50),
              Text('Live Kurs:',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              Center(
                child: StreamBuilder(
                    stream: goldPrice,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done ||
                          snapshot.connectionState == ConnectionState.active) {
                        return Text(
                          NumberFormat.simpleCurrency(locale: 'de_DE')
                              .format(snapshot.data),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        );
                      } else if (snapshot.connectionState !=
                          ConnectionState.done) {
                        return const CircularProgressIndicator();
                      } else {
                        return const Icon(Icons.error);
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Image(
          image: AssetImage('assets/bars.png'),
          width: 100,
        ),
        Text('Gold', style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}
