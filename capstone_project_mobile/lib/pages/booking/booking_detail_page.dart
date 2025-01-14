import 'package:capstone_project_mobile/components/cards/booking_card.dart';
import 'package:capstone_project_mobile/constants/status_constant.dart';
import 'package:capstone_project_mobile/core/controller/appointment_controller.dart';
import 'package:capstone_project_mobile/core/model/appointment.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/shared/error_screen.dart';
import 'package:capstone_project_mobile/shared/loading_screen.dart';
import 'package:capstone_project_mobile/utils/date_format_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetailPage extends StatelessWidget {
  final String bookingId;

  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  BookingDetailPage({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Booking Detail'),
      body: RefreshIndicator(
        onRefresh: () async {
          await appointmentController.fetchOneAppointment(bookingId);
        },
        child: FutureBuilder(
          future: appointmentController.getSingleAppointment(bookingId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var appointment = snapshot.data!;
              return _buildBody(appointment, context);
            }
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(25.0),
                child: ErrorScreen(
                  onTryAgain: () async {
                    await appointmentController.getSingleAppointment(bookingId);
                  },
                  errorObject: snapshot.error,
                ),
              );
            }
            return const LoadingScreen();
          },
        ),
      ),
    );
  }
}

Widget _buildBody(Appointment appointment, BuildContext context) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;

  TextStyle headingStyle =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w500);
  TextStyle subHeadingStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  TextStyle titleStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  TextStyle descriptionStyle =
      TextStyle(fontSize: 16, color: colorScheme.tertiary);

  return SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appointment With',
            style: subHeadingStyle,
          ),
          const SizedBox(height: 16),
          BookingCard(appointment: appointment),
          const SizedBox(height: 16),
          _informationSection(appointment, colorScheme, headingStyle,
              titleStyle, descriptionStyle),
          const SizedBox(height: 24),
          _scheduleSection(appointment, colorScheme, headingStyle, titleStyle,
              descriptionStyle),
          const SizedBox(height: 16),
          Divider(
            thickness: 0.5,
            color: colorScheme.tertiary,
          ),
          const SizedBox(height: 4),
          if (appointment.status == StatusConstant.completed.name) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notes from doctor',
                    style: subHeadingStyle,
                  ),
                  const SizedBox(height: 12),
                  Text(appointment.note),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prescriptions',
                    style: subHeadingStyle,
                  ),
                  const SizedBox(height: 12),
                  Text(appointment.prescriptions),
                ],
              ),
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total', style: subHeadingStyle),
                const Spacer(),
                Flexible(
                  child: Text(
                    "4 coins",
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.visible,
                    style: descriptionStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Booking Price', style: subHeadingStyle),
                const Spacer(),
                Flexible(
                  child: Text(
                    "2 coins",
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.visible,
                    style: descriptionStyle,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        ],
      ),
    ),
  );
}

Widget _informationSection(Appointment appointment, ColorScheme colorScheme,
    TextStyle headingStyle, TextStyle titleStyle, TextStyle descriptionStyle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Information',
        style: headingStyle,
      ),
      Divider(
        thickness: 0.5,
        color: colorScheme.tertiary,
      ),
      const SizedBox(height: 16),
      _descriptionRow("Patient's Number", "003", colorScheme, headingStyle,
          titleStyle, descriptionStyle),
      const SizedBox(height: 16),
      _descriptionRow("Username", appointment.patient.username, colorScheme,
          headingStyle, titleStyle, descriptionStyle),
      const SizedBox(height: 16),
      _descriptionRow("Symtoms", appointment.symptoms, colorScheme,
          headingStyle, titleStyle, descriptionStyle)
    ],
  );
}

Widget _scheduleSection(Appointment appointment, ColorScheme colorScheme,
    TextStyle headingStyle, TextStyle titleStyle, TextStyle descriptionStyle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Schedule',
        style: headingStyle,
      ),
      Divider(
        thickness: 0.5,
        color: colorScheme.tertiary,
      ),
      const SizedBox(height: 16),
      _descriptionRow(
          "Date",
          DateFormatHelper.formatDate(appointment.scheduleDate),
          colorScheme,
          headingStyle,
          titleStyle,
          descriptionStyle),
      const SizedBox(height: 16),
      _descriptionRow(
          "Time",
          "${appointment.startTime} - ${appointment.endTime}",
          colorScheme,
          headingStyle,
          titleStyle,
          descriptionStyle),
    ],
  );
}

Widget _descriptionRow(String title, String desription, ColorScheme colorScheme,
    TextStyle headingStyle, TextStyle titleStyle, TextStyle descriptionStyle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: titleStyle),
      const Spacer(),
      Flexible(
        child: Text(
          desription,
          textAlign: TextAlign.end,
          overflow: TextOverflow.visible,
          style: descriptionStyle,
        ),
      ),
    ],
  );
}
