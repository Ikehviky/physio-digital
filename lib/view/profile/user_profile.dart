import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physio_digital/controllers/home_controller.dart';
import 'package:physio_digital/services/auth/auth_service.dart';
import 'package:physio_digital/view/home/buttom_bar.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _logout();
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    try {
      final AuthService _auth = AuthService();
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(homeController),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF354AD9),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(35)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 250,
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          _buildHeaderTopRow(context),
          _buildProfileImage(),
          const SizedBox(height: 10),
          _buildProfileName(),
        ],
      ),
    );
  }


  Widget _buildHeaderTopRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.storefront, color: Colors.white),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () => _confirmLogout(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.logout, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color.fromARGB(255, 218, 218, 218),
          width: 1.0,
        ),
      ),
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/physio-logo.jpg'),
      ),
    );
  }

  Widget _buildProfileName() {
    return const Text(
      'PhysioDigital Asistant',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      margin: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildExpandableSection(
                'About App (PhysioDigital Assistant)',
                'PhysioDigital Assistant (a software product from PhysioDigital Services) is an innovative mobile application designed to revolutionize access to physiotherapy and rehabilitation services in Nigeria. The app serves as a comprehensive platform connecting patients with certified physiotherapists, enabling users to purchase and access physiotherapy equipment and providing updates on the latest in physiotherapy practice.\n\nKey features include:\n'
                    '• Clinician-Patient Connection: Facilitates direct communication between patients and physiotherapists for consultations and treatment plans.\n'
                    '• Equipment Marketplace: Offers a wide range of physiotherapy and health equipment for purchase.\n'
                    '• Educational Resources: Provides news, scholarships, internships, webinars, and conferences updates.\n'
                    '• User-Friendly Interface: Designed for ease of use, ensuring accessibility for users of all technical abilities.\n'
                    '• Secure Transactions: Ensures all purchases and communications are secure and confidential.',
                Icons.info_outline,
              ),
              _buildExpandableSection(
                'About Physiotherapy',
                'Physiotherapy, also known as physical therapy, is a healthcare profession dedicated to improving and restoring physical function and mobility in patients who have experienced injury, illness, or disability. Physiotherapists use evidence-based techniques and a holistic approach to promote health and well-being, preventing further injury or illness.\n\nKey aspects include:\n'
                    '• Assessment and Diagnosis: Thorough evaluation of patients to determine the root cause of physical issues.\n'
                    '• Treatment and Rehabilitation: Development of personalized treatment plans incorporating exercises, manual therapy, and other modalities to enhance recovery.\n'
                    '• Education and Advice: Providing patients with information on injury prevention, healthy lifestyles, and exercises to maintain or improve physical health.\n'
                    '• Specializations: Includes areas like musculoskeletal, neurological, cardiovascular, and respiratory physiotherapy, catering to diverse patient needs.',
                Icons.medical_services_outlined,
              ),
              _buildExpandableSection(
                'History of Physiotherapy in Nigeria',
                'Early Beginnings (1950s-1960s):\n'
                    '• Introduction to Nigeria: Physiotherapy was introduced by British-trained physiotherapists in the late 1950s, practicing primarily in hospitals in major cities like Lagos and Ibadan.\n'
                    '• First Training Programs: The first physiotherapy training program was established at the University College Hospital (UCH), Ibadan, in 1966, affiliated with the University of Ibadan.\n\n'
                    'Formation of Professional Bodies (1959-1980s):\n'
                    '• Nigerian Society of Physiotherapy (NSP): Established in 1959, it was the first professional body for physiotherapists in Nigeria.\n'
                    '• Professional Advocacy: NSP played a significant role in advocating for the inclusion of physiotherapists in the healthcare system.\n\n'
                    'Regulatory Framework and Growth (1980s-1990s):\n'
                    '• Medical Rehabilitation Therapists Board of Nigeria (MRTBN): Established in 1988 to regulate and control the training and practice of physiotherapy.\n'
                    '• Expansion of Training Programs: Universities like Lagos and Nigeria, Nsukka, began offering physiotherapy programs.\n\n'
                    'Modern Developments (2000s-Present):\n'
                    '• Increase in Educational Institutions: Several universities now offer undergraduate and postgraduate programs in physiotherapy.\n'
                    '• Specialization and Continuing Education: Rise in specialization and continuing professional development programs.\n'
                    '• Technological Integration: Integration of technology like telehealth and physiotherapy apps.\n'
                    '• Professional Recognition and International Collaboration: Increased international recognition and collaboration.',
                Icons.history_edu_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableSection(String title, String content, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xFF354AD9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: ExpansionTile(
              title: Text(
                'Expand for details',
                style: TextStyle(
                  color: Color(0xFF354AD9),
                  fontWeight: FontWeight.w500,
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    content,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              iconColor: Color(0xFF354AD9),
              collapsedIconColor: Color(0xFF354AD9),
              childrenPadding: EdgeInsets.all(0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(HomeController homeController) {
    return Obx(
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
    );
  }
}