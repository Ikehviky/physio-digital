import 'package:flutter/material.dart';
import 'package:physio_digital/model/therapist/therapist.dart';

import '../../../exports.dart';

class TherapistProfileScreen extends StatelessWidget {
  final Therapist therapist;
  const TherapistProfileScreen({Key? key, required this.therapist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(26, 53, 75, 217),
        centerTitle: true,
        title: const Text(
          "Therapist Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildSection('About', therapist.about ?? 'No information provided'),
              _buildSection('Education', therapist.education ?? 'No information provided'),
              _buildServicesSection(),
              _buildAvailabilitySection(),
              _buildSection('Location', therapist.location ?? 'No location provided'),
              _buildContactSection(),
              const SizedBox(height: 16),
              _buildAppointmentButton(),
              const SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(therapist.images.isNotEmpty ? therapist.images.first : 'assets/images/default_profile.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                therapist.name ?? 'Unknown Name',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(therapist.location ?? 'Unknown Location'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(content),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Services',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: therapist.services.map((service) => Chip(label: Text(service))).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAvailabilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Availability',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: therapist.availability.map((day) => Chip(label: Text(day))).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Info',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(therapist.phone ?? 'No phone provided'),
        Text(therapist.email ?? 'No email provided'),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAppointmentButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () => _launchWhatsApp(therapist.phone),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF354AD9),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),

        ),
        child: const Text(
          'Schedule Appointment',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _launchWhatsApp(String? phone) async {
    if (phone == null || phone.isEmpty) {
      // Handle the case where no phone number is available
      print('No phone number available for this therapist');
      return;
    }

    // Remove any non-digit characters from the phone number
    String cleanPhone = phone.replaceAll(RegExp(r'\D'), '');

    // Construct the WhatsApp URL
    String whatsappUrl = "https://wa.me/$cleanPhone";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      // Handle the case where WhatsApp can't be launched
      print('Could not launch WhatsApp');
    }
  }

}