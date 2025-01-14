import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/layouts/layout_page.dart';
import 'package:capstone_project_mobile/pages/login/login_email_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BecomeTherapistPage3 extends StatefulWidget {
  const BecomeTherapistPage3({super.key});

  @override
  State<BecomeTherapistPage3> createState() => _BecomeTherapistPage3State();
}

class _BecomeTherapistPage3State extends State<BecomeTherapistPage3> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: const MyAppBar(
        title: "Therapist Sign Up",
        actionsEnabled: true,
      ),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return SizedBox(
      height: 50, // Set the desired height for the BottomAppBar
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        elevation: 0,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(
                  color: Colors.black, // Change the text color if needed
                  fontSize: 16, // Adjust the font size if needed
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const LoginEmail(),
                    ),
                  );
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.blue, // Change the text color if needed
                    fontSize: 16, // Adjust the font size if needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start
          children: [
            Text(
              "Upload your certificates and other necessary documents",
              overflow: TextOverflow.visible,
              style: textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            _buildFileUploadButton(context),
            const SizedBox(height: 20),
            _buildStack(),
            const SizedBox(height: 20),
            _buildTakePhoto(context),
            const SizedBox(height: 20),
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFileUploadButton(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ElevatedButton(
        onPressed: () async {
          //upload file
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.onPrimary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: const TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
          side: const BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.image_outlined),
              color: Colors.grey,
            ),
            const Text(
              'Upload File',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const LayoutPage(selectedIndex: 0),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          textStyle: const TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
        ),
        child: const Text('Next'),
      ),
    );
  }

  Widget _buildStack() {
    return const Stack(
      alignment: Alignment.center,
      children: [
        // Container with optional adjustments
        SizedBox(
          width: double.infinity,
          height: 20.0,
        ),
        Positioned(
          left: 0.0, // Position at left edge
          right: 0.0, // Position at right edge
          top: 15.0, // Adjust vertical position within the container
          child: Divider(
            height: 2.0, // Adjust line thickness
            color: Colors.grey, // Adjust line color
          ),
        ),
        // Centered Text (optional)
        Positioned(
          child: Text(
            "\u00A0\u00A0\u00A0\u00A0 or \u00A0\u00A0\u00A0\u00A0",
            style: TextStyle(
              fontSize: 20.0, // Adjust font size as needed
              color: Colors.black, // Adjust text color
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTakePhoto(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _picker.pickImage(source: ImageSource.camera);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: colorScheme.onPrimary,
          textStyle: const TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
        ),
        child: const Text('Take a Photo'),
      ),
    );
  }
}
