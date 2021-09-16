import 'package:flutter/material.dart';

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    this.onPressed,
    required this.icon,
    required this.color,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: const CircleBorder(),
      elevation: 10,
      color: color,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
