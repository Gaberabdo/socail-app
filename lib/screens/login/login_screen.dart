import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:social/screens/home/home_screen.dart';
import 'package:social/screens/login/cubit/login_cubit.dart';
import 'package:social/screens/login/cubit/login_states.dart';

import '../../helper/cache/cache_helper.dart';
import '../../helper/component/component.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            navigatorTo(context, HomeScreen());
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: ProsteThirdOrderBezierCurve(
                          position: ClipPosition.bottom,
                          list: [
                            ThirdOrderBezierCurveSection(
                              p1: const Offset(0, 300),
                              p2: const Offset(0, 400),
                              p3: const Offset(550, 240),
                              p4: const Offset(550, 400),
                              smooth: 1,
                            ),
                          ],
                        ),
                        child: Container(
                          height: 400,
                          width: double.maxFinite,
                          color: Colors.indigo,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome Back',
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
                              height: 15,
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
                                    onPressed: () {
                                      cubit.changePasswordVisibility();
                                    },
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
                              condition: state is! LoadingLoginState,
                              builder: (context) => MaterialButton(
                                clipBehavior: Clip.none,
                                minWidth: double.infinity,
                                color: Colors.indigo,
                                height: 35,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: Text(
                                  'Login',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: GoogleFonts.eduNswActFoundation(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegisterScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    icon: Text(
                                      'Register',
                                      style: GoogleFonts.eduNswActFoundation(
                                        fontSize: 20,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
