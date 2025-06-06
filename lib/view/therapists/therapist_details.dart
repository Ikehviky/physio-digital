import 'package:flutter/material.dart';
import 'package:physio_digital/view/therapists/availability_section.dart';
import 'package:physio_digital/view/therapists/contact_info.dart';
import 'package:physio_digital/view/therapists/location_section.dart';
import 'package:physio_digital/view/therapists/profile_details.dart';
import 'package:physio_digital/view/therapists/profile_header.dart';
import 'package:physio_digital/view/therapists/service_section.dart';
// import 'package:physio_consult/views/user/therapist/review_section.dart';
// import 'package:physio_consult/views/user/therapist/shedule_appointmen.dart';

class TherapistProfileScreen extends StatelessWidget {
  const TherapistProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(26, 53, 75, 217),
        centerTitle: true,
        title: const Text(
          "Therapist",
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
            children: [
              const ProfileHeader(),
              const SizedBox(height: 16),
              const ProfileDetails(),
              const SizedBox(height: 16),
              const ServicesSection(),
              const SizedBox(height: 16),
              const AvailabilitySection(),
              const SizedBox(height: 16),
              const LocationSection(),
              const SizedBox(height: 16),
              const ContactInfoSection(),
              const SizedBox(height: 16),
              // ReviewsSection(),
              // SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF354AD9),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20)
                ),
                child: const Text(
                  'Schedule Appointment',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                ],
              ),
              const SizedBox(height: 26),

            ],
          ),
        ),
      ),
    );
  }
}
