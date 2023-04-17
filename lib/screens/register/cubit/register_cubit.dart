import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/model/user_model.dart';
import 'package:social/screens/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(LoadingRegisterState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid!,
      );
    }).catchError((onError) {
      emit(ErrorRegisterState());
      print(onError.toString());
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) async {
    UserModel model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      image:
          'https://th.bing.com/th/id/R.0ca63da31834bd7f000acdb43f1a4d8f?rik=qvP5nfTg3%2fFrjg&riu=http%3a%2f%2fthe-skill-factory.com%2fwp-content%2fuploads%2f2019%2f11%2fblank-profile-picture-png-6-1.jpg&ehk=Kfo7bkcUpALnrqkxrSGxxKGbyEDBsh9uJikAkpsdQ4c%3d&risl=&pid=ImgRaw&r=0',
      cover:
          'https://th.bing.com/th/id/OIP.ijtcUIjnGO9MCM_HId6jhAAAAA?pid=ImgDet&rs=1',
      bio: 'write you bio ...',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SuccessCreateUserState(model!.uId!));
    }).catchError((onError) {
      print(
          'asdddddddddddddddddddddddddddddddddddddddddddddd${onError.toString()}');
      emit(ErrorCreateUserState());
    });
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
