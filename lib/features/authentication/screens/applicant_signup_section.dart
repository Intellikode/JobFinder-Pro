import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';
import '../widgets/auth_field.dart';

class ApplicantSignupSection extends ConsumerStatefulWidget {
  const ApplicantSignupSection({super.key});

  @override
  ConsumerState<ApplicantSignupSection> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<ApplicantSignupSection> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // late File image;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Future<File?> pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final imageFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (imageFile != null) {
  //     return File(imageFile.path);
  //   }
  //   return null;
  // }

  // Future<void> pickImage2() async {
  //   final image = await PickFile.pickImage();
  // }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).applicantSignUp(
        email: emailController.text,
        password: passwordController.text,
        context: context,
        name: ''
        // file: image,
        );
  }

  bool showObscureText = true;

  void showHidePassword() {
    setState(() {
      showObscureText = !showObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return isLoading
        ? const CircularProgressIndicator()
        : Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomAuthField(
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  CustomAuthField(
                    controller: passwordController,
                    hintText: 'Password',
                    showObscureText: showObscureText,
                    isPasswordField: true,
                    showPasswordFunc: showHidePassword,
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: onSignUp,
                    child: const Text('Done'),
                  ),
                  // ElevatedButton(
                  //     onPressed: pickImage2,
                  //     child: const Text('pickImage')),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
  }
}
