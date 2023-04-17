import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:social/helper/cache/cache_helper.dart';
import 'package:social/screens/home/home_screen.dart';
import 'package:social/screens/register/cubit/register_cubit.dart';
import 'package:social/screens/register/cubit/register_states.dart';

import '../../helper/component/component.dart';
import '../login/cubit/login_cubit.dart';
import '../login/cubit/login_states.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var globalFormKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var imageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is SuccessCreateUserState) {
            navigatorTo(
              context,
              HomeScreen(),
            );
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            );
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: ProsteThirdOrderBezierCurve(
                          position: ClipPosition.bottom,
                          list: [
                            ThirdOrderBezierCurveSection(
                              smooth: 1,
                              p1: const Offset(0, 200),
                              p2: const Offset(0, 300),
                              p3: const Offset(450, 140),
                              p4: const Offset(450, 300),
                            ),
                          ],
                        ),
                        child: Container(
                          height: 300,
                          width: double.maxFinite,
                          color: Colors.indigo,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Create Account',
                                style: GoogleFonts.eduNswActFoundation(
                                  fontSize: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            TextFormField(
                              cursorColor: Colors.black,
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter your full name';
                                }
                                return null;
                              },
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: GoogleFonts.eduNswActFoundation(
                                      fontSize: 20, color: Colors.black),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: .9, color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.brown),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              cursorColor: Colors.black,
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter your phone number';
                                }
                                return null;
                              },
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                  labelText: 'Phone',
                                  labelStyle: GoogleFonts.eduNswActFoundation(
                                      fontSize: 20, color: Colors.black),
                                  prefixIcon: const Icon(
                                    Icons.call,
                                    color: Colors.black,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: .9, color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.brown),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              cursorColor: Colors.black,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter your email address';
                                }
                                return null;
                              },
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: GoogleFonts.eduNswActFoundation(
                                      fontSize: 20, color: Colors.black),
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.black,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: .9, color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.brown),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              cursorColor: Colors.black,
                              controller: passwordController,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: cubit.isPassword,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter your email password';
                                }
                                return null;
                              },
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                  labelText: 'password',
                                  labelStyle: GoogleFonts.eduNswActFoundation(
                                      fontSize: 20, color: Colors.black),
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      cubit.suffix,
                                      color: Colors.black,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: .9, color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.brown),
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoadingRegisterState,
                              builder: (context) => MaterialButton(
                                clipBehavior: Clip.none,
                                minWidth: double.infinity,
                                color: Colors.indigo,
                                height: 35,
                                onPressed: () {
                                  if (globalFormKey.currentState!.validate()) {
                                    cubit.userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.eduNswActFoundation(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              fallback: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black54,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 15.0),
                                    child: const Divider(
                                      color: Colors.black,
                                      height: 50,
                                    )),
                              ),
                              const Text("OR"),
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 15.0, right: 10.0),
                                    child: const Divider(
                                      color: Colors.black,
                                      height: 50,
                                    )),
                              ),
                            ]),
                            OutlinedButton(
                              onPressed: () {
                                navigatorTo(
                                  context,
                                  LoginScreen(),
                                );
                              },
                              child: Container(
                                height: 35,
                                width: double.infinity,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Login',
                                  style: GoogleFonts.eduNswActFoundation(
                                    fontSize: 20,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
