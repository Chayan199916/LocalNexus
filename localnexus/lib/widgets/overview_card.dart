import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int value;
  final Color color;

  const OverviewCard({
    required this.title,
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Icon(
                    icon,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Active $title',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 4,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
