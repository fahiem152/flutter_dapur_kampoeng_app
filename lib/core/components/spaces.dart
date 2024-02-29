// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SpaceHeight extends StatelessWidget {
  final double height;
  const SpaceHeight(this.height, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}

class SpaceWidth extends StatelessWidget {
  final double width;
  const SpaceWidth(this.width, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: width);
}
