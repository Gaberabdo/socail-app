import 'package:boopbook/screens/register/cubit/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/user_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  Future<void> UserRigster({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    emit(LoadingRegisterState());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        email: email,
        uid: value.user!.uid,
        username: username,
        phone: phone,
        password: password,
      );
    }).catchError((onError) {
      emit(ErrorRegisterState());
      print(onError.toString());
    });
  }

  Future<void> userCreate({
    required String email,
    required String uid,
    required String username,
    required String phone,
    required String password,
  }) async {
    UserModel model = UserModel(
      email: email,
      phone: phone,
      uId: uid,
      name: username,
      bio: 'Write bio',
      image:
          'https://tse2.mm.bing.net/th?id=OIP.vGDCJnsOvLDbVBWhXTMDqQHaD4&pid=Api',
      cover:
          'https://tse2.mm.bing.net/th?id=OIP.vGDCJnsOvLDbVBWhXTMDqQHaD4&pid=Api',
    );
    print('user done');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap());
    emit(SuccessCreateUserState(model!.uId!));
    print('donnnne');
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
