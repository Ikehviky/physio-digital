import 'dart:io';
import 'package:get/get.dart';
import 'package:physio_digital/model/clinic/clinic.dart';
import 'package:physio_digital/repository/clinic_repository.dart';

class ListClinicController extends GetxController {
  final ClinicRepository clinicRepository;
  final RxList<Clinic> clinics = <Clinic>[].obs;
  final Rx<Clinic?> selectedClinic = Rx<Clinic?>(null);
  final RxInt hoveredIndex = RxInt(-1);
  final RxBool isLoading = true.obs;
  final RxBool isSingleClinicLoading = false.obs;

  ListClinicController(this.clinicRepository);

  @override
  void onInit() {
    super.onInit();
    fetchClinics();
  }

  Future<void> fetchClinics() async {
    try {
      isLoading.value = true;
      final fetchedClinics = await clinicRepository.getAllClinic();
      clinics.assignAll(fetchedClinics);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch clinics: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchClinic(String clinicId) async {
    try {
      isSingleClinicLoading.value = true;
      final fetchedClinic = await clinicRepository.getClinic(clinicId);
      selectedClinic.value = fetchedClinic;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch clinic: $e');
    } finally {
      isSingleClinicLoading.value = false;
    }
  }

  Future<void> removeClinic(String clinicId) async {
    try {
      await clinicRepository.removeClinic(clinicId);
      await fetchClinics();
      Get.snackbar('Success', 'Clinic removed successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove clinic: $e');
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      return await clinicRepository.uploadImage(image);
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      rethrow;
    }
  }

  void setHoveredIndex(int index) {
    hoveredIndex.value = index;
  }
}