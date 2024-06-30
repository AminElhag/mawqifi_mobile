import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';

class ProfileActionItem extends StatefulWidget {
  const ProfileActionItem({super.key, required this.title, required this.icon, required this.onTap});

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<ProfileActionItem> createState() => _ProfileActionItemState();
}

class _ProfileActionItemState extends State<ProfileActionItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: SizedBox(
        height: 32,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Icon(
                widget.icon,
                color: TColor.primary,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 18, color: TColor.primary),
            )
          ],
        ),
      ),
    );
  }
}
