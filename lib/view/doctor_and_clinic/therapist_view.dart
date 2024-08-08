import 'package:physio_digital/model/therapist/therapist.dart';
import 'package:physio_digital/view/doctor_and_clinic/therapists/therapist_profile_screen.dart';
import '../../exports.dart';

class TherapistCard extends StatelessWidget {
  final Therapist therapist;

  const TherapistCard({Key? key, required this.therapist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => TherapistProfileScreen(therapist: therapist));
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: therapist.images.isNotEmpty
                ? NetworkImage(therapist.images[0])
                : AssetImage('assets/default_therapist_image.png') as ImageProvider,
          ),
          title: Text(therapist.name ?? 'Unknown'),
          subtitle: Text(therapist.location ?? 'No location'),
        ),
      ),
    );
  }
}