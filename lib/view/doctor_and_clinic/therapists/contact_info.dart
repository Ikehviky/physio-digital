import 'package:flutter/material.dart';

class ContactInfoSection extends StatelessWidget {
  const ContactInfoSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Info',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Text('+234-5455-45332'),
        Text('johndoe@gmail.com'),
      ],
    );
  }
}
