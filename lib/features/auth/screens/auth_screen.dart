import 'package:flutter/material.dart';
import 'package:sundari/common/widgets/custom_button.dart';
import 'package:sundari/common/widgets/password_textfield.dart';
import 'package:sundari/constants/global_variables.dart';
import 'package:sundari/constants/notification_service.dart';
import 'package:sundari/features/auth/services/auth_service.dart';

import '../../../common/widgets/custom_textfield.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  NotificationsServices notificationsServices = NotificationsServices();

  @override
  void initState() {
    super.initState();
    notificationsServices.initialiseNotifications();
  }

  @override
  Widget build(BuildContext context) {
    //Navigator.pushNamed(context, '', arguments: );
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: GlobalVariables.authScreenGradient,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  tileColor: Colors.transparent,
                  title: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.transparent,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextfield(
                            controller: _nameController,
                            hintText: "Name",
                            prefixIcon: const Icon(Icons.list_rounded),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                            controller: _emailController,
                            hintText: "Email",
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PassTextfield(
                            controller: _passwordController,
                            hintText: "Password",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              text: 'Sign Up',
                              onTap: () {
                                notificationsServices.scheduleNotification(
                                    'Delta',
                                    'Take a look at the new food items. Have a finger licking experience. Make your next meal from Delta');
                                if (_signUpFormKey.currentState!.validate()) {
                                  signUpUser();
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: Colors.transparent,
                  title: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.transparent,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextfield(
                            controller: _emailController,
                            hintText: "Email",
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PassTextfield(
                            controller: _passwordController,
                            hintText: "Password",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              text: 'Sign In',
                              onTap: () {
                                notificationsServices.scheduleNotification(
                                    'Delta',
                                    'Get exciting orders and deals available just on you. Make your next meal finger licking. Order it quickly.');
                                if (_signInFormKey.currentState!.validate()) {
                                  signInUser();
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                Center(
                  child: Image.asset(
                    'assets/images/foodstop.gif',
                    height: 180,
                    width: 180,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
