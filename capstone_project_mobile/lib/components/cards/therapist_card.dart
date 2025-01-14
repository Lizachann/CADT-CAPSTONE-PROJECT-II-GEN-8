import 'package:capstone_project_mobile/core/model/therapist.dart';
import 'package:capstone_project_mobile/pages/therapists/detail_therapist_page.dart';
import 'package:flutter/material.dart';

class TherapistCard extends StatelessWidget {
  const TherapistCard(
      {super.key, required this.therapist, this.isNavigate = false});

  final Therapist therapist;
  final bool? isNavigate;

  @override
  Widget build(BuildContext context) {
    const TextStyle primaryTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

    const TextStyle secondaryTextStyle =
        TextStyle(color: Colors.black, fontSize: 16);
    return GestureDetector(
      onTap: () => {
        if (isNavigate == true)
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) =>
                        DetailTherapistPage(therapistId: therapist.id)))
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
        child: Row(
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
                    "Dr. ${therapist.firstName} ${therapist.lastName}",
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
                      children: List.generate(therapist.specializations.length,
                          (index) {
                        return Text(
                          index == therapist.specializations.length - 1
                              ? '${therapist.specializations[index]}'
                              : '${therapist.specializations[index]}, ',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
