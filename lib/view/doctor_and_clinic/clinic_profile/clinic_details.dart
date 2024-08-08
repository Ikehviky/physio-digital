import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/clinic/clinic.dart';

class ClinicDetails extends StatelessWidget {
  final Clinic clinic;

  const ClinicDetails({Key? key, required this.clinic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(139, 194, 201, 244),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLocationInfo(),
                      const SizedBox(height: 16),
                      _buildServiceInfo(),
                      const SizedBox(height: 16),
                      _buildClinicInfo(),
                      const SizedBox(height: 16),
                      _buildAvailabilityInfo(),
                    ],
                  ),
                ),
              ),
            ),
            _buildScheduleButton(),
            const SizedBox(height: 26),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          clinic.images.isNotEmpty ? clinic.images.first : 'https://via.placeholder.com/400x200',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 200,
          color: const Color.fromARGB(255, 18, 20, 34).withOpacity(0.7),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: NetworkImage(clinic.images.isNotEmpty ? clinic.images.first : 'https://via.placeholder.com/48x48'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                clinic.name ?? 'Unknown Clinic',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(clinic.description ?? 'No location information available')),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Contact info',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.phone_outlined, size: 20),
            const SizedBox(width: 8),
            Text(clinic.phone ?? 'No phone number available'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.email_outlined, size: 20),
            const SizedBox(width: 8),
            Text(clinic.email ?? 'No email available'),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Services',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: clinic.services.map((service) => Chip(
            label: Text(service, style: const TextStyle(color: Colors.black)),
            shape: const StadiumBorder(side: BorderSide(color: Colors.transparent)),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildClinicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Clinic Info',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(clinic.description ?? 'No clinic information available'),
      ],
    );
  }

  Widget _buildAvailabilityInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Availability',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.date_range, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(clinic.availability.join(', '))),
          ],
        ),
      ],
    );
  }

  Widget _buildScheduleButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _openWhatsApp(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF354AD9),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          ),
          child: const Text(
            'Schedule Appointment via WhatsApp',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _openWhatsApp() async {
    String phoneNumber = clinic.phone ?? '';

    if (phoneNumber.isEmpty) {
      // Handle the case where phone number is not available
      print('Phone number not available for this clinic');
      return;
    }

    // Remove any non-digit characters from the phone number
    phoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]+'), '');

    // Construct the WhatsApp URL
    String whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      // Handle the case where WhatsApp couldn't be launched
      print('Could not launch WhatsApp');
    }
  }
}