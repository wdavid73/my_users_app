import 'package:flutter/material.dart';
import 'package:my_users_app/config/config.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: FlutterLogo(
        size: context.dp(7),
      ),
    );
  }
}
