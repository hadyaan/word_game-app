import 'package:flutter/material.dart';

class SliderSelectionWidget extends StatelessWidget {
  final String title;
  final double value;
  final double minValue;
  final double maxValue;
  final ValueChanged<double> onChanged;

  const SliderSelectionWidget({
    super.key,
    required this.title,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
