import 'package:physio_digital/view/doctor_and_clinic/therapists/listTherapist/list_therapist_view.dart';

import '../../exports.dart';
import 'listclinic/list_clinic_view.dart';

class Clinic extends StatefulWidget {
  const Clinic({Key? key}) : super(key: key);

  @override
  ClinicState createState() => ClinicState();
}

class ClinicState extends State<Clinic> {
  final HomeController homeController = Get.find();

  final List<String> categories = [
    'Therapist',
    'Clinic',
  ];

  String activeCategory = 'Therapist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(26, 53, 75, 217),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 30.0, horizontal: 15.0),
              child: Row(
                children: [
                  const Icon(Icons.article),
                  const SizedBox(width: 3),
                  const Text(
                    'Clinic',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const Spacer(),
                  // IconButton(
                  //   onPressed: () {
                  //     print('clinic');
                  //   },
                  //   icon: const Icon(
                  //     Icons.search,
                  //     color: Colors.black,
                  //   ),
                  // )
                ],
              ),
            ),
            // const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 10.0),
              child: SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isActive = category == activeCategory;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            activeCategory = category;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: isActive ?const Color(0xFF354AD9): Colors.white,
                          foregroundColor: isActive ? Colors.white : Colors.black,
                        ),
                        child: Text(category),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(child: _buildCategoryView()),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
            () => CustomBottomNavigationBar(
          currentIndex: homeController.currentIndex.value,
          onTap: (index) {
            homeController.changeIndex(index);
            switch (index) {
              case 0:
                Get.toNamed('/');
                break;
              case 1:
                Get.toNamed('/marketplace');
                break;
              case 2:
                Get.toNamed('/clinic');
                break;
              case 3:
                Get.toNamed('/blog');
                break;
              case 4:
                Get.toNamed('/profile');
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _buildCategoryView() {
    switch (activeCategory) {
      case 'Therapist':
        return const ListTherapistView();
      case 'Clinic':
        return ClinicsView();
      default:
        return const ListTherapistView();
        // return const TherapistView();
    }
  }
}