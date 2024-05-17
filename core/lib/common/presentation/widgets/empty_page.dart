import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String? label;
  final IconData icon;
  final double? height;

  const EmptyPage({
    Key? key,
    this.label,
    this.icon = Icons.archive,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: height ?? 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.grey.shade400, size: 70),
            const SizedBox(height: 20),
            Text(
              label ?? 'Data is not found',
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }
}
