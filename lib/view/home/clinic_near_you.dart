import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:physio_digital/model/clinic/clinic.dart';
import 'package:physio_digital/repository/clinic_repository.dart';
import '../doctor_and_clinic/clinic_profile/clinic_details.dart';
import 'dart:math';

class ClinicsNearYouController extends GetxController {
  final ClinicRepository _repository = ClinicRepositoryImpl();
  final RxList<Clinic> nearbyClinicss = <Clinic>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNearbyClinicss();
  }

  Future<void> fetchNearbyClinicss() async {
    try {
      isLoading.value = true;
      List<Clinic> allClinicss = await _repository.getAllClinic();

      // Randomly select up to 5 clinics
      final random = Random();
      allClinicss.shuffle(random);
      nearbyClinicss.value = allClinicss.take(5).toList();
    } catch (e) {
      print('Error fetching nearby clinics: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

class ClinicNearYou extends StatelessWidget {
  final ClinicsNearYouController controller = Get.put(ClinicsNearYouController());

  ClinicNearYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Clinics Near You', onViewAll: () {}),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return _buildClinicList();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {required VoidCallback onViewAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicList() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.nearbyClinicss.length,
        itemBuilder: (context, index) {
          return _buildClinicCard(controller.nearbyClinicss[index]);
        },
      ),
    );
  }

  Widget _buildClinicCard(Clinic clinic) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ClinicDetails(clinic: clinic));
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              clinic.images.isNotEmpty
                  ? Image.network(
                clinic.images.first,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
                  : Image.asset(
                'assets/images/placeholder_clinic.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8)),
                  ),
                  child: const FaIcon(FontAwesomeIcons.stethoscope, color: Colors.white, size: 14),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
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
                        overflow: TextOverflow.ellipsis,
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