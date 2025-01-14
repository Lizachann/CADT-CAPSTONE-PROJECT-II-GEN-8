import 'package:capstone_project_mobile/core/model/therapist.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/pages/booking/booking_page.dart';
import 'package:capstone_project_mobile/core/services/get_service.dart';
import 'package:capstone_project_mobile/shared/loading_screen.dart';
import 'package:flutter/material.dart';

class DetailTherapistPage extends StatefulWidget {
  const DetailTherapistPage({super.key, required this.therapistId});

  final String therapistId;

  @override
  State<DetailTherapistPage> createState() => _DetailTherapistPageState();
}

class _DetailTherapistPageState extends State<DetailTherapistPage> {
  late Future<Therapist> futureTherapist;

  @override
  void initState() {
    super.initState();
    futureTherapist = GetService.fetchOneTherapist(widget.therapistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: 'Detailed Therapist',
        ),
        body: FutureBuilder(
          future: futureTherapist,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var therapist = snapshot.data;

              return Scaffold(body: _buildBody(therapist, context));
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const LoadingScreen();
          },
        ));
  }

  Widget _buildBody(Therapist? therapist, BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    const TextStyle secondaryTextStyle =
        TextStyle(color: Colors.black, fontSize: 16);

    const TextStyle primaryTextStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16);

    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      backgroundColor: themeColor.inversePrimary,
      elevation: 3,
      shadowColor: Colors.grey[200],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/images/therapist1.png',
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.all(8),
            alignment: Alignment.topLeft,
            child: Text(
              "Dr. ${therapist!.firstName} ${therapist.lastName}",
              overflow: TextOverflow.visible,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          Divider(
            color: themeColor.tertiary,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  style: textButtonStyle,
                  child: const Text('Message', style: primaryTextStyle),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookingPage(therapist: therapist)));
                  },
                  style: textButtonStyle,
                  child:
                      const Text('Book Appointment', style: primaryTextStyle),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Specializations:', style: primaryTextStyle),
              const Spacer(),
              Flexible(
                flex: 2,
                child: Wrap(
                    direction: Axis.horizontal,
                    children: List.generate(therapist.specializations.length,
                        (index) {
                      return Text(
                        index == therapist.specializations.length - 1
                            ? '${therapist.specializations[index]}'
                            : '${therapist.specializations[index]}, ',
                        overflow: TextOverflow.visible,
                        style: secondaryTextStyle,
                      );
                    })),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Gender:', style: primaryTextStyle),
              const Spacer(),
              Flexible(
                flex: 2,
                child: Text(
                  therapist.gender == 'male' ? 'Male' : 'Female',
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
              const Text('Username:', style: primaryTextStyle),
              const Spacer(),
              Flexible(
                flex: 2,
                child: Text(
                  '@${therapist.username}',
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
              const Text('Phone Number:', style: primaryTextStyle),
              const Spacer(),
              Flexible(
                child: Text(
                  therapist.phoneNumber,
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
              const Text('Session Price:', style: primaryTextStyle),
              const Spacer(),
              Flexible(
                child: Text(
                  '${therapist.hourlyRate} Coins/hr',
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.visible,
                  style: secondaryTextStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
