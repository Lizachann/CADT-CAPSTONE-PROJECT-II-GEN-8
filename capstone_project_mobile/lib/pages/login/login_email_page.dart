import 'package:capstone_project_mobile/components/dialogs/error_dialog.dart';
import 'package:capstone_project_mobile/core/controller/auth_controller.dart';
import 'package:capstone_project_mobile/core/model/error_response.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/layouts/layout_page.dart';
import 'package:capstone_project_mobile/pages/login/widgets/email_field.dart';
import 'package:capstone_project_mobile/pages/login/widgets/forget_password.dart';
import 'package:capstone_project_mobile/pages/login/widgets/password_field.dart';
import 'package:capstone_project_mobile/pages/login/widgets/sign_in_button.dart';
import 'package:capstone_project_mobile/pages/login/widgets/sign_up_button.dart';
import 'package:capstone_project_mobile/pages/login/widgets/thearapist_sign_up_button.dart';
import 'package:capstone_project_mobile/pages/therapist_sign_up/input_information_page.dart';
import 'package:capstone_project_mobile/shared/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_phone_page.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({super.key});

  @override
  LoginEmailState createState() => LoginEmailState();
}

class LoginEmailState extends State<LoginEmail> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  void _signIn() {
    _authController.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  void _loginPhone() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const LoginPhone()),
    );
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const RegisterEmail()),
    );
  }

  void _navigateToTherapistSignUp() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const BecomeTherapistPage1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Login with email"),
      body: Obx(() {
        if (_authController.isLoading.value) {
          return const LoadingScreen();
        } else if (_authController.isLoggedIn.value) {
          // return const LayoutPage();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAll(() => const LayoutPage());
          });
          return const SizedBox.shrink();
        } else {
          return LoginBody(
            obscureText: _obscureText,
            onToggleObscureText: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            onSignIn: _signIn,
            emailController: _emailController,
            passwordController: _passwordController,
            onLoginPhone: _loginPhone,
            onRegister: _navigateToRegister,
            onTherapistSignUp: _navigateToTherapistSignUp,
          );
        }
      }),
      // bottomNavigationBar: const LoginBottomAppBar(),
    );
  }
}

class RegisterEmail extends StatefulWidget {
  const RegisterEmail({super.key});

  @override
  RegisterEmailState createState() => RegisterEmailState();
}

class RegisterEmailState extends State<RegisterEmail> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  void _register() async {
    await _authController
        .register(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    )
        .then((value) {
      Get.snackbar('Register successful', 'Please login to your account');
      Get.to(() => const LoginEmail());
    }).catchError((err) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(err);
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          text: errorResponse.validationMessages.toString(),
        ),
      );
    });
    // print(RegisterResponse.fromJson(res));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Register with email"),
      body: Obx(() {
        if (_authController.isLoading.value) {
          return const LoadingScreen();
        } else if (_authController.isLoggedIn.value) {
          return const LayoutPage();
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                EmailField(controller: _emailController),
                const SizedBox(height: 16),
                PasswordField(
                  obscureText: _obscureText,
                  onToggleObscureText: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  controller: _passwordController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text("Register"),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

class LoginBody extends StatelessWidget {
  final bool obscureText;
  final VoidCallback onToggleObscureText;
  final VoidCallback onSignIn;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLoginPhone;
  final VoidCallback onRegister;
  final VoidCallback onTherapistSignUp;

  const LoginBody({
    super.key,
    required this.obscureText,
    required this.onToggleObscureText,
    required this.onSignIn,
    required this.emailController,
    required this.passwordController,
    required this.onLoginPhone,
    required this.onRegister,
    required this.onTherapistSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          EmailField(controller: emailController),
          const SizedBox(height: 16),
          PasswordField(
            obscureText: obscureText,
            onToggleObscureText: onToggleObscureText,
            controller: passwordController,
          ),
          const SizedBox(height: 10),
          const ForgotPasswordButton(),
          const SizedBox(height: 20),
          SignInButton(onSignIn: onSignIn),
          const SizedBox(height: 140),
          // const Text(
          //   "Sign in with",
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: 20,
          //   ),
          // ),
          const SizedBox(height: 10),
          // PhoneSignInButton(onLoginPhone: onLoginPhone),
          const SizedBox(height: 10),
          // const GoogleSignInButton(),
          const SizedBox(height: 20),
          SignUpText(onPressed: onRegister),
          TherapistSignUp(onTherapistSignUp: onTherapistSignUp),
        ],
      ),
    );
  }
}
