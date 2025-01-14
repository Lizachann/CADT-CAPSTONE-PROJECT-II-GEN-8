import 'package:capstone_project_mobile/components/cards/booking_card.dart';
import 'package:capstone_project_mobile/core/controller/appointment_controller.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/shared/error_screen.dart';
import 'package:capstone_project_mobile/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingListPage extends StatelessWidget {
  BookingListPage({super.key});

  final AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: 'All Bookings',
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await appointmentController.fetchAllAppointments();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  FutureBuilder(
                    future: appointmentController.getAllAppointments(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var appointments = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              appointmentController.allAppointments.length,
                          itemBuilder: (ctx, index) {
                            return Container(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: BookingCard(
                                isNavigate: true,
                                appointment: appointments[index],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: ErrorScreen(
                            onTryAgain: () async {
                              await appointmentController
                                  .fetchAllAppointments();
                            },
                            errorObject: snapshot.error,
                          ),
                        );
                      }
                      return const LoadingScreen();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
