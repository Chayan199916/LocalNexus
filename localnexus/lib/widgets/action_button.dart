import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int? badgeValue;
  final Color? badgeColor;
  final bool fullWidth;
  final VoidCallback? onPressed; // Callback for button press

  const ActionButton(
      {required this.icon,
      required this.label,
      this.badgeValue,
      this.badgeColor,
      this.fullWidth = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.secondary,
          onPrimary: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
