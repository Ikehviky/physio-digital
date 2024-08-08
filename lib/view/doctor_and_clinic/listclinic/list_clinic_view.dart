import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../clinic_profile/clinic_details.dart';
import 'package:physio_digital/model/clinic/clinic.dart';
import 'package:physio_digital/repository/clinic_repository.dart';

class ClinicsController extends GetxController {
  final ClinicRepository _repository = ClinicRepositoryImpl();
  final RxList<Clinic> clinics = <Clinic>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchClinics();
  }

  Future<void> fetchClinics() async {
    try {
      isLoading.value = true;
      clinics.value = await _repository.getAllClinic();
    } catch (e) {
      print('Error fetching clinics: $e');
      // You might want to show an error message to the user here
    } finally {
      isLoading.value = false;
    }
  }
}

class ClinicsView extends StatelessWidget {
  final ClinicsController controller = Get.put(ClinicsController());

  ClinicsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.75,
            ),
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.clinics.length,
            itemBuilder: (context, index) {
              return _buildClinicCard(controller.clinics[index]);
            },
          );
        }
      }),
    );
  }

  Widget _buildClinicCard(Clinic clinic) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ClinicDetails(clinic: clinic));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              clinic.images.isNotEmpty
                  ? Image.network(
                clinic.images.first,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/images/placeholder_clinic.jpg',
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clinic.name ?? 'Unknown Clinic',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        clinic.description ?? 'No location available',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}