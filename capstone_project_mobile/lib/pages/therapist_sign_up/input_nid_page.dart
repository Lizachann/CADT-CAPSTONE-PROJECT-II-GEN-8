// import 'dart:io';

// import 'package:capstone_project_mobile/components/dialogs/error_dialog.dart';
// import 'package:capstone_project_mobile/core/controller/therapist_controller.dart';
// import 'package:capstone_project_mobile/core/model/error_response.dart';
// import 'package:capstone_project_mobile/layouts/layout_page.dart';
// import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
// import 'package:capstone_project_mobile/pages/therapist_sign_up/upload_certificates_page.dart';
// import 'package:capstone_project_mobile/pages/login/login_email_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class BecomeTherapistPage2 extends StatefulWidget {
//   final String firstName;
//   final String lastName;
//   final String email;

//   const BecomeTherapistPage2(
//       {super.key,
//       required this.email,
//       required this.firstName,
//       required this.lastName});

//   @override
//   State<BecomeTherapistPage2> createState() => _BecomeTherapistPage2State();
// }

// class _BecomeTherapistPage2State extends State<BecomeTherapistPage2> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();
//   List<XFile> postImages = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.white,
//       appBar: const MyAppBar(
//         title: "Therapist Sign Up",
//         actionsEnabled: true,
//       ),
//       body: _buildBody(context),
//       bottomNavigationBar: _buildBottomAppBar(context),
//     );
//   }

//   Widget _buildBottomAppBar(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       child: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         color: Colors.white,
//         elevation: 0,
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Already have an account?",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                       builder: (context) => const LoginEmail(),
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   "Sign In",
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBody(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Input National ID",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//               ),
//             ),
//             const SizedBox(height: 20),
//             _buildFileUploadButton(context),
//             const SizedBox(height: 20),
//             _buildStack(),
//             const SizedBox(height: 20),
//             _buildTakePhoto(context),
//             const SizedBox(height: 20),
//             UploadButton(
//               postImages: postImages,
//               firstName: widget.firstName,
//               lastName: widget.lastName,
//               email: widget.email,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFileUploadButton(BuildContext context) {
//     ColorScheme colorScheme = Theme.of(context).colorScheme;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.85,
//           height: 80,
//           child: ElevatedButton(
//             onPressed: () async {
//               List<XFile>? images = await _picker.pickMultiImage();
//               // if (images.isEmpty) return;
//               setState(() {
//                 postImages = images;
//               });
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: colorScheme.onPrimary,
//               foregroundColor: colorScheme.onPrimary,
//               textStyle: const TextStyle(fontSize: 20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               padding: const EdgeInsets.symmetric(
//                 vertical: 15,
//                 horizontal: 10,
//               ),
//               side: const BorderSide(
//                 color: Colors.grey,
//                 width: 2.0,
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.image_outlined),
//                   color: Colors.grey,
//                 ),
//                 const Text(
//                   'Upload File',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 20,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if (postImages.isNotEmpty)
//           Expanded(
//             child: ListView.builder(
//               itemCount: postImages.length,
//               itemBuilder: (context, index) => Image.file(
//                 File(postImages[index].path),
//                 height: 200,
//                 width: 200,
//               ),
//             ),
//           )
//         else
//           const Text(''),
//       ],
//     );
//   }

//   Widget _buildNextButton(BuildContext context) {
//     ColorScheme colorScheme = Theme.of(context).colorScheme;

//     return SizedBox(
//       width: double.infinity,
//       height: 60,
//       child: ElevatedButton(
//         onPressed: () {
//           if (_formKey.currentState!.validate()) {
//             Navigator.push(
//               context,
//               CupertinoPageRoute(
//                 builder: (context) => const BecomeTherapistPage3(),
//               ),
//             );
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: colorScheme.primary,
//           foregroundColor: Theme.of(context).colorScheme.onPrimary,
//           textStyle: const TextStyle(fontSize: 20),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(100),
//           ),
//           padding: const EdgeInsets.symmetric(
//             vertical: 15,
//             horizontal: 10,
//           ),
//         ),
//         child: const Text('Upload'),
//       ),
//     );
//   }

//   Widget _buildStack() {
//     return const Stack(
//       alignment: Alignment.center,
//       children: [
//         SizedBox(
//           width: double.infinity,
//           height: 20.0,
//         ),
//         Positioned(
//           left: 0.0,
//           right: 0.0,
//           top: 15.0,
//           child: Divider(
//             height: 2.0,
//             color: Colors.grey,
//           ),
//         ),
//         Positioned(
//           child: Text(
//             "\u00A0\u00A0\u00A0\u00A0 or \u00A0\u00A0\u00A0\u00A0",
//             style: TextStyle(
//               fontSize: 20.0,
//               color: Colors.black,
//               backgroundColor: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTakePhoto(BuildContext context) {
//     ColorScheme colorScheme = Theme.of(context).colorScheme;

//     return SizedBox(
//       width: double.infinity,
//       height: 60,
//       child: ElevatedButton(
//         onPressed: () {
//           if (_formKey.currentState!.validate()) {
//             _picker.pickImage(source: ImageSource.camera);
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue,
//           foregroundColor: colorScheme.onPrimary,
//           textStyle: const TextStyle(fontSize: 20),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(100),
//           ),
//           padding: const EdgeInsets.symmetric(
//             vertical: 15,
//             horizontal: 10,
//           ),
//         ),
//         child: const Text('Take a Photo'),
//       ),
//     );
//   }
// }

// class UploadButton extends StatelessWidget {
//   final List<XFile> postImages;
//   final String firstName;
//   final String lastName;
//   final String email;

//   const UploadButton({
//     super.key,
//     required this.postImages,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final TherapistController uploadController = Get.put(TherapistController());
//     ColorScheme colorScheme = Theme.of(context).colorScheme;

//     return SizedBox(
//       width: double.infinity,
//       height: 60,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: colorScheme.primary,
//           foregroundColor: Theme.of(context).colorScheme.onPrimary,
//           textStyle: const TextStyle(fontSize: 20),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(100),
//           ),
//           padding: const EdgeInsets.symmetric(
//             vertical: 15,
//             horizontal: 10,
//           ),
//         ),
//         onPressed: () async {
//           await uploadController
//               .handleTherapistSignup(
//                   firstName: firstName,
//                   lastName: lastName,
//                   email: email,
//                   status: 'requested',
//                   postImages: postImages)
//               .then((value) {
//             Navigator.push(
//               context,
//               CupertinoPageRoute(
//                 builder: (context) => const LayoutPage(selectedIndex: 0),
//               ),
//             );
//           }).catchError((err) {
//             ErrorResponse errorResponse = ErrorResponse.fromJson(err);
//             showDialog(
//               context: context,
//               builder: (context) => ErrorDialog(
//                 text: errorResponse.validationMessages.toString(),
//               ),
//             );
//           });
//         },
//         child: const Text('Upload'),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:capstone_project_mobile/components/dialogs/error_dialog.dart';
import 'package:capstone_project_mobile/core/controller/therapist_controller.dart';
import 'package:capstone_project_mobile/layouts/layout_page.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/pages/login/login_email_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BecomeTherapistPage2 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;

  const BecomeTherapistPage2({
    super.key,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<BecomeTherapistPage2> createState() => _BecomeTherapistPage2State();
}

class _BecomeTherapistPage2State extends State<BecomeTherapistPage2> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  List<XFile> postImages = [];

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
      height: 50,
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
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 10),
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
                    color: Colors.blue,
                    fontSize: 16,
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload your National ID, certificates and other necessary documents",
              style: TextStyle(
                overflow: TextOverflow.visible,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            _buildFileUploadButton(context),
            const SizedBox(height: 20),
            _buildStack(),
            const SizedBox(height: 20),
            _buildTakePhoto(context),
            const SizedBox(height: 20),
            UploadButton(
              postImages: postImages,
              firstName: widget.firstName,
              lastName: widget.lastName,
              email: widget.email,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileUploadButton(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 80,
          child: ElevatedButton(
            onPressed: () async {
              List<XFile>? images = await _picker.pickMultiImage();
              // if (images != null) {
              setState(() {
                postImages = images;
              });
              // }
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  color: Colors.grey,
                ),
                Text(
                  'Upload File',
                  // postImages.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStack() {
    return Center(
      child: SizedBox(
        width: 150,
        height: 150,
        child: Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: postImages.isEmpty
                  ? const Center(
                      child: Text(
                        "No image selected",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: postImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            File(postImages[index].path),
                          ),
                        );
                      },
                    ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    postImages.clear();
                  });
                },
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTakePhoto(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () async {
          XFile? image = await _picker.pickImage(
              source: ImageSource.camera, imageQuality: 50);
          if (image != null) {
            setState(() {
              postImages.add(image);
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: colorScheme.onPrimary,
          textStyle: const TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
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

class UploadButton extends StatefulWidget {
  final List<XFile>? postImages;
  final String firstName;
  final String lastName;
  final String email;

  const UploadButton({
    super.key,
    this.postImages,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  final TherapistController therapistController =
      Get.put(TherapistController());

  Future<void> _handleSignUp() async {
    if (widget.postImages != null && widget.postImages!.isNotEmpty) {
      try {
        await therapistController.handleTherapistSignup(
          firstName: widget.firstName,
          lastName: widget.lastName,
          email: widget.email,
          status: 'requested',
          postImages: widget.postImages,
        );

        if (mounted) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const LayoutPage(selectedIndex: 0),
            ),
          );
        }
      } catch (error) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(
                text: "Upload Error",
              );
            },
          );
        }
      }
    } else {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ErrorDialog(
              text: "No Images Selected",
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          textStyle: const TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
        ),
        onPressed: _handleSignUp,
        child: const Text("Submit"),
      ),
    );
  }
}
