import 'package:flutter/material.dart';

class EBooScreen extends StatefulWidget {
  const EBooScreen({super.key});

  @override
  State<EBooScreen> createState() => _EBooScreenState();
}

class _EBooScreenState extends State<EBooScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
