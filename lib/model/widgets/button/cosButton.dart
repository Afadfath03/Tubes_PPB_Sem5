import 'package:flutter/material.dart';
import '../../colors.dart'; 

class cosButton extends StatelessWidget {
  final String? label;
  final Color? color;
  final IconData? icon;
  final VoidCallback? onPressed;

  const cosButton({Key? key, this.label, this.color, this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? ColorsCollection.accentOrange, 
        borderRadius: BorderRadius.circular(20), 
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: ColorsCollection.accentWhite, 
              ),
              const SizedBox(width: 8), 
            ],
            Text(
              label ?? "Button", 
              style: const TextStyle(
                color: ColorsCollection.accentWhite, 
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
