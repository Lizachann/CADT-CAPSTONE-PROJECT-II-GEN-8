import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/pages/booking/booking_list_page.dart';
import 'package:capstone_project_mobile/pages/booking/session_history.dart';
import 'package:capstone_project_mobile/pages/profile/coins_payment_page.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class YourActivity extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  YourActivity({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorScheme.surface,
        appBar: const MyAppBar(
          title: "Your Activity",
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildbutton(
            context,
            'Stress Records',
            LucideIcons.activity,
            (BuildContext context) => CoinsPaymentPage(),
          ),
          _buildbutton(
            context,
            'Saved Activity',
            LucideIcons.bike,
            (BuildContext context) => CoinsPaymentPage(),
          ),
          _buildbutton(
            context,
            'Saved Resource',
            LucideIcons.library,
            (BuildContext context) => CoinsPaymentPage(),
          ),
          _buildbutton(
            context,
            'Coin and Payment',
            LucideIcons.helpingHand,
            (BuildContext context) => CoinsPaymentPage(),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text(
              'Therapist',
              style: TextStyle(
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          _buildbutton(
            context,
            'Booking',
            LucideIcons.ticket,
            (BuildContext context) => BookingListPage(),
          ),
          _buildbutton(
            context,
            'Session History',
            LucideIcons.bookCopy,
            (BuildContext context) => SessionHistory(),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text(
              'Community',
              style: TextStyle(
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          _buildbutton(
            context,
            'Post History',
            LucideIcons.history,
            (BuildContext context) => CoinsPaymentPage(),
          ),
          _buildbutton(
            context,
            'Save Posts',
            LucideIcons.bookmark,
            (BuildContext context) => CoinsPaymentPage(),
          ),
          _buildbutton(
            context,
            'Liked Posts',
            LucideIcons.heart,
            (BuildContext context) => CoinsPaymentPage(),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text(
              'More',
              style: TextStyle(
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          _buildbutton(
            context,
            'Terms and Agreement',
            LucideIcons.scale,
            (BuildContext context) => CoinsPaymentPage(),
          ),
          _buildbutton(
            context,
            'Help and Service',
            LucideIcons.fileText,
            (BuildContext context) => CoinsPaymentPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildbutton(BuildContext context, String text, IconData icon,
      Function(BuildContext) navigation) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigation(context)),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: colorScheme.primary,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 0,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(217, 217, 217, 1),
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(
                  icon,
                  size: 24,
                  color: colorScheme.primary,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
