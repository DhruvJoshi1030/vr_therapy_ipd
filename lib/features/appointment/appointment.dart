import 'package:flutter/material.dart';
import 'package:vr_therapy_ipd/colors.dart';
import 'package:vr_therapy_ipd/styleCard.dart';
import 'package:intl/intl.dart';
class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2024));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Book An Appointment',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Time: ${TimeOfDay.now().format(context)}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add code to handle the booking here
                // For example, you can send the selected date and time to a database or print it to the console.
                print(
                    'Appointment booked on ${DateFormat('yyyy-MM-dd').format(DateTime.now())} at ${TimeOfDay.now().format(context)}');
                Navigator.pop(context);
              },
              child: Text('Book Appointment', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
            ),
          ],
        ),
      );
    },
  );
}


  @override
  List<Doctor> doctors = [
    Doctor(name: 'Dr. Smith', specialization: 'Cardiologist'),
    Doctor(name: 'Dr. Johnson', specialization: 'Dermatologist'),
    Doctor(name: 'Dr. Williams', specialization: 'Gynecologist'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book an Appointment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  return StyleCard(
                    // title: Text(doctors[index].name),
                    // subtitle: Text(doctors[index].specialization),
                    // onTap: () {
                    //   // Add code to handle doctor selection here
                    //   print('Selected Doctor: ${doctors[index].name}');
                    // },
                    title: (doctors[index].name),
                    img: "assets/icons/delete.svg",
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    description: doctors[index].specialization,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Doctor {
  final String name;
  final String specialization;

  Doctor({required this.name, required this.specialization});
}
