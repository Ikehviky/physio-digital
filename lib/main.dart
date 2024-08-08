import 'package:physio_digital/view/doctor_and_clinic/therapists/listTherapist/list_therapist_controller.dart';
import 'package:physio_digital/repository/post_repository.dart';
import 'package:physio_digital/view/posts/listPost/list_post_controller.dart';
import 'exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  await initializeDependencies();
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
    rethrow; // Rethrow the error to prevent the app from continuing if Firebase fails to initialize
  }
}

Future<void> initializeDependencies() async {
  // Repositories
  Get.put<ProductRepository>(ProductRepositoryImpl());
  Get.put<TherapistRepository>(TherapistRepositoryImpl());
  Get.put<ClinicRepository>(ClinicRepositoryImpl());
  Get.put<PostRepository>(PostRepositoryImpl());

  // Controllers
  Get.put(HomeController());
  Get.put(ListAllTherapistsController(Get.find<TherapistRepository>()));
  Get.put(ListClinicController(Get.find<ClinicRepository>()));
  Get.put(ListProductController(Get.find<ProductRepository>()));
  Get.put(PostController(postRepository: Get.find<PostRepository>()));

  // Verify that repositories and controllers are registered
  print('TherapistRepository registered: ${Get.isRegistered<TherapistRepository>()}');
  print('ClinicRepository registered: ${Get.isRegistered<ClinicRepository>()}');
  print('ProductRepository registered: ${Get.isRegistered<ProductRepository>()}');
  print('PostRepository registered: ${Get.isRegistered<PostRepository>()}');
  print('ListClinicController registered: ${Get.isRegistered<ListClinicController>()}');
  print('ListProductController registered: ${Get.isRegistered<ListProductController>()}');
  print('PostController registered: ${Get.isRegistered<PostController>()}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/marketplace', page: () => const ListProducts()),
        GetPage(name: '/clinic', page: () => const Clinic()),
        GetPage(name: '/blog', page: () => const ListPostsPage()),
        GetPage(name: '/profile', page: () => const UserProfile()),
      ],
      theme: lightMode,
      home: const AuthGate(),
      initialBinding: RegistrationBinding(),
    );
  }
}