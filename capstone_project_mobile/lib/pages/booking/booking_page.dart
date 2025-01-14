import 'package:capstone_project_mobile/components/cards/therapist_card.dart';
import 'package:capstone_project_mobile/components/dialogs/error_dialog.dart';
import 'package:capstone_project_mobile/core/model/therapist.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/core/model/dto/create_appointment.dart';
import 'package:capstone_project_mobile/pages/booking/booking_list_page.dart';
import 'package:capstone_project_mobile/layouts/layout_page.dart';
import 'package:capstone_project_mobile/core/services/post_service.dart';
import 'package:capstone_project_mobile/shared/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.therapist});
  final Therapist therapist;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  void initState() {
    super.initState();
    _updateEndTime();
  }

  String formatTimeWithoutAmPm(TimeOfDay? time) {
    final hour = time!.hourOfPeriod
        .toString()
        .padLeft(2, '0'); // Use hourOfPeriod for 12-hour format without AM/PM
    final minute = time.minute
        .toString()
        .padLeft(2, '0'); // Pad minutes with leading zero if needed
    return '$hour:$minute';
  }

  final bool isDisabled = false;

  // final TextEditingController _notesController = TextEditingController();
  final TextEditingController _symtomsController = TextEditingController();
  final TextEditingController _durationController =
      TextEditingController(text: '1');

  final TextEditingController _dateController = TextEditingController();
  bool loading = false;

  Future handleBooking() async {
    setState(() {
      loading = true;
    });

    if (_symtomsController.text.isEmpty || _dateController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              const ErrorDialog(text: 'Please input the required fields.'));
    } else {
      var res = await PostService.createAppointment(
        CreateAppointment(
            symptoms: _symtomsController.text,
            therapist: widget.therapist.id,
            patient: '63686861790123456789abcd',
            scheduleDate: _dateController.text,
            startTime: formatTimeWithoutAmPm(startTime),
            endTime: formatTimeWithoutAmPm(endTime),
            duration: int.parse(_durationController.text)),
      ).then(
        (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuccessScreen(
                successMsg: 'Booking Completed',
                backBtnTitle: 'Go to Therapist Page',
                nextBtnTitle: 'View Booking Details',
                backBtn: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LayoutPage(
                        selectedIndex: 2,
                      ),
                    ),
                  );
                },
                nextBtn: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BookingListPage()),
                  );
                },
              ),
            ),
          );
          _symtomsController.clear();
          _dateController.clear();
          return value;
        },
      ).catchError((err) {
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(text: err['messages'][0]),
        );
      }).whenComplete(
        () => setState(() {
          loading = false;
        }),
      );
      return res;
    }
  }

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay? endTime;

  void _updateEndTime() {
    String durationText = _durationController.text;

    if (durationText.isEmpty || durationText == '0') {
      durationText = '1';
    }

    final int value = int.parse(durationText);
    Duration duration;

    duration = Duration(hours: value);

    final endTime24 = _addDurationToTime(startTime, duration);
    setState(() {
      endTime = endTime24;
    });
  }

  TimeOfDay _addDurationToTime(TimeOfDay time, Duration duration) {
    final now = DateTime.now();
    final startDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    final endDateTime = startDateTime.add(duration);
    return TimeOfDay(
      hour: endDateTime.hour,
      minute: endDateTime.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle secondaryTextStyle =
        TextStyle(color: Colors.black, fontSize: 16);

    const TextStyle primaryTextStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16);
    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 3,
      shadowColor: Colors.grey[500],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(128)),
      ),
    );
    return Scaffold(
      appBar: const MyAppBar(title: 'Book Appointment'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Apppointment with',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const SizedBox(height: 16),
              TherapistCard(therapist: widget.therapist),
              const SizedBox(height: 16),
              const Text(
                'Information',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              _textField(
                  hintText: 'Insomnia, Stress, Tired...',
                  label: 'Symptoms',
                  controller: _symtomsController),
              const SizedBox(height: 16),
              const Text(
                'Schedule',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.calendar_month),
                  label: RichText(
                    text: const TextSpan(
                        text: 'Schedule Date',
                        style: TextStyle(
                            color: Color.fromARGB(255, 70, 70, 70),
                            fontSize: 18),
                        children: [
                          TextSpan(
                              text: ' *', style: TextStyle(color: Colors.red))
                        ]),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: 'YYYY/MM/DD',
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onTap: () {
                  _selectDate();
                },
              ),
              const SizedBox(height: 16),
              TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  if (int.parse(_durationController.text) == 0 ||
                      _durationController.text.isEmpty) {
                    _durationController.text = '1';
                  }
                  _updateEndTime();
                },
                keyboardType: TextInputType.number,
                controller: _durationController,
                maxLength: 1,
                decoration: InputDecoration(
                  label: RichText(
                    text: const TextSpan(
                        text: 'Duration (Hour)',
                        style: TextStyle(
                            color: Color.fromARGB(255, 70, 70, 70),
                            fontSize: 18),
                        children: [
                          TextSpan(
                              text: ' *', style: TextStyle(color: Colors.red))
                        ]),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: '1',
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              _buildTimePick("Start time", "Start time", true, startTime, (x) {
                setState(() {
                  startTime = x;
                  _updateEndTime();
                });
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Session Price:', style: primaryTextStyle),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      '${widget.therapist.hourlyRate} Coins/hrs',
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.visible,
                      style: secondaryTextStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total:', style: primaryTextStyle),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      '${widget.therapist.hourlyRate * int.parse(_durationController.text)} Coins',
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.visible,
                      style: secondaryTextStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: handleBooking,
                      style: textButtonStyle,
                      child: const Text('Book Appointment',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePick(String title, String hintText, bool ifPickedTime,
      TimeOfDay currentTime, Function(TimeOfDay) onTimePicked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            selectedTime(context, ifPickedTime, currentTime, onTimePicked);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16)),
            child: Text(currentTime.format(context)),
          ),
        ),
      ],
    );
  }

  Widget _textField({required hintText, required label, required controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
              text: label,
              style: const TextStyle(
                  color: Color.fromARGB(255, 70, 70, 70), fontSize: 18),
              children: const [
                TextSpan(text: ' *', style: TextStyle(color: Colors.red))
              ]),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future selectedTime(BuildContext context, bool ifPickedTime,
      TimeOfDay initialTime, Function(TimeOfDay) onTimePicked) async {
    var pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.input);
    if (pickedTime != null) {
      onTimePicked(pickedTime);
    }
  }
}
