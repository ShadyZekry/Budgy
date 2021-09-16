import 'package:flutter/material.dart';

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.accentColor,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
