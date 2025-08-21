import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/ui/widgets/adaptive_scaffold.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AppBar(
        title: Text("Register User"),
      ),
      child: const Placeholder(),
    );
  }
}
