import 'package:flutter/material.dart';

class ScheduleAppointmentButton extends StatelessWidget {
  const ScheduleAppointmentButton(Key? key) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Add your onPressed functionality here
        },
        child: const  Text('Schedule Appointment'),
      ),
    );
  }
}
