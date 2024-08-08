import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physio_digital/repository/therapist_repository.dart';
import 'package:physio_digital/model/therapist/therapist.dart';
import 'package:physio_digital/view/doctor_and_clinic/therapists/therapist_profile_screen.dart';
import 'list_therapist_controller.dart';

class ListTherapistView extends StatelessWidget {
  const ListTherapistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListAllTherapistsController>(
      init: ListAllTherapistsController(Get.find<TherapistRepository>()),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.refreshTherapists,
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (controller.errorMessage.isNotEmpty) {
                      return Center(child: Text(controller.errorMessage.value));
                    } else if (controller.therapists.isEmpty) {
                      return const Center(child: Text('No therapists found'));
                    } else {
                      return ListView.builder(
                        itemCount: controller.therapists.length,
                        itemBuilder: (context, index) {
                          final therapist = controller.therapists[index];
                          return TherapistCard(
                            therapist: therapist,
                          );
                        },
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TherapistCard extends StatelessWidget {
  final Therapist therapist;

  const TherapistCard({
    Key? key,
    required this.therapist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: therapist.images.isNotEmpty
              ? NetworkImage(therapist.images[0])
              : const AssetImage('assets/default_therapist_image.png') as ImageProvider,
        ),
        title: Text(therapist.name ?? 'Unknown'),
        subtitle: Text(therapist.education ?? 'No education information'),
        onTap: () {
          Get.to(() => TherapistProfileScreen(therapist: therapist));
        },
      ),
    );
  }
}