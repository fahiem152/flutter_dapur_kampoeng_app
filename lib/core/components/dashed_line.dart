import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: List.generate(
          400 ~/ 10,
          (index) => Expanded(
            child: Container(
              color: index % 2 == 1 ? Colors.transparent : Colors.grey,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
