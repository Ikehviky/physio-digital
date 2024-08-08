import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Chip(label: Text('Massage therapy')),
            SizedBox(width: 8),
            Chip(label: Text('Acupuncture')),
          ],
        ),
      ],
    );
  }
}
