import 'package:capstone_project_mobile/constants/status_constant.dart';
import 'package:capstone_project_mobile/core/model/appointment.dart';
import 'package:capstone_project_mobile/pages/booking/booking_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BookingCard extends StatelessWidget {
  final Appointment appointment;

  final bool? isNavigate;

  const BookingCard(
      {super.key, required this.appointment, this.isNavigate = false});

  @override
  Widget build(BuildContext context) {
    const TextStyle primaryTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    const TextStyle secondaryTextStyle =
        TextStyle(color: Colors.black, fontSize: 16);

    Color boxColor;
    if (appointment.status.toLowerCase() ==
        StatusConstant.requested.name.toString()) {
      boxColor = const Color.fromRGBO(253, 185, 53, 1);
    } else if (appointment.status.toLowerCase() ==
        StatusConstant.scheduled.name.toString()) {
      boxColor = const Color.fromRGBO(74, 198, 0, 1);
    } else if (appointment.status.toLowerCase() ==
        StatusConstant.completed.name.toString()) {
      boxColor = const Color.fromARGB(255, 70, 70, 70);
    } else {
      boxColor = const Color.fromRGBO(224, 0, 0, 1);
    }

    String status;
    if (appointment.status.toLowerCase() ==
        StatusConstant.requested.name.toString()) {
      status = 'Pending';
    } else if (appointment.status.toLowerCase() ==
        StatusConstant.scheduled.name.toString()) {
      status = 'Accepted';
    } else if (appointment.status.toLowerCase() ==
        StatusConstant.completed.name.toString()) {
      status = 'Completed';
    } else {
      status = 'Cancelled';
    }

    return GestureDetector(
      onTap: () {
        if (isNavigate == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BookingDetailPage(bookingId: appointment.id)));
        }
      },
      child: Container(
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
            (Row(
              children: [
                Image.asset(
                  'lib/assets/images/Doctor_profile_icon.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. ${appointment.therapist.firstName} ${appointment.therapist.lastName}",
                        overflow: TextOverflow.visible,
                        style: primaryTextStyle,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Therapist',
                        style: secondaryTextStyle,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Specialized in ',
                        style: secondaryTextStyle,
                      ),
                      Wrap(
                          direction: Axis.horizontal,
                          children: List.generate(
                              appointment.therapist.specializations.length,
                              (index) {
                            return Text(
                              index ==
                                      appointment.therapist.specializations
                                              .length -
                                          1
                                  ? '${appointment.therapist.specializations[index]}'
                                  : '${appointment.therapist.specializations[index]}, ',
                              overflow: TextOverflow.visible,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            );
                          })),
                    ],
                  ),
                ),
              ],
            )),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      LucideIcons.helpCircle,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Status: ',
                      style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.tertiary,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                      color: boxColor, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    status,
                    style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.background,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
