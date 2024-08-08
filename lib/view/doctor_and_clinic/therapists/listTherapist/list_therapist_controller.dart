import 'package:get/get.dart';
import 'package:physio_digital/model/therapist/therapist.dart';
import 'package:physio_digital/repository/therapist_repository.dart';

class ListAllTherapistsController extends GetxController {
  final TherapistRepository _repository;
  final RxList<Therapist> therapists = <Therapist>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  ListAllTherapistsController(this._repository);

  @override
  void onInit() {
    super.onInit();
    refreshTherapists();
  }

  Future<void> refreshTherapists() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final fetchedTherapists = await _repository.getAllTherapist();
      therapists.assignAll(fetchedTherapists);
    } catch (e) {
      errorMessage.value = 'Failed to fetch therapists: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTherapist(String therapistId) async {
    try {
      await _repository.removeTherapist(therapistId);
      therapists.removeWhere((therapist) => therapist.id == therapistId);
    } catch (e) {
      errorMessage.value = 'Failed to delete therapist: ${e.toString()}';
    }
  }

  void sortTherapistsByName({bool ascending = true}) {
    therapists.sort((a, b) => ascending
        ? a.name!.compareTo(b.name!)
        : b.name!.compareTo(a.name!));
    therapists.refresh();
  }

  List<Therapist> searchTherapists(String query) {
    return therapists.where((therapist) =>
    therapist.name!.toLowerCase().contains(query.toLowerCase()) ||
        therapist.email!.toLowerCase().contains(query.toLowerCase()) ||
        therapist.phone!.contains(query)).toList();
  }
}