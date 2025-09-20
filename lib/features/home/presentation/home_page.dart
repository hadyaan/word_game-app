import 'package:flutter/material.dart';
import 'package:word_game/features/home/widgets/slider_selection_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String route = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guess It',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  letterSpacing: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Choose your game settings',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontSize: 20),
              ),
              SizedBox(height: 32),
              SliderSelectionWidget(
                title: 'Word Length',
                value: 5,
                minValue: 4,
                maxValue: 7,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
