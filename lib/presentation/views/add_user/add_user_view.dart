import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:posbank/domain/entities/intrest_model.dart';
import 'package:posbank/presentation/resources/strings_manager.dart';
import 'package:posbank/presentation/utilm/utilm.dart';
import 'package:posbank/app/app_constants.dart';
import 'package:posbank/presentation/views/add_user/add_user_view_model.dart';
import 'dart:convert';
import '../../../app/di.dart';
import '../../resources/values_manager.dart';
import '../note/note_view_model.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({Key? key}) : super(key: key);

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  bool isPassword = true;
  InterestModel? currentInterestModel;

  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final AddUserViewModel _viewModel = instance<AddUserViewModel>();

  @override
  void initState() {
    bind();
    super.initState();
  }

  bind() {
    _viewModel.start();
    userNameCtrl.addListener(() {
      _viewModel.setUserName(userNameCtrl.text);
    });
    passwordCtrl.addListener(() {
      _viewModel.setPassword(passwordCtrl.text);
    });
    emailCtrl.addListener(() {
      _viewModel.setEmail(emailCtrl.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StateType>(
        stream: _viewModel.outputSaveState,
        builder: (c, snapShot) {
          return snapShot.data == StateType.loading ? _loading() : _content();
        });
  }

  Widget _loading() => Scaffold(
        body: Center(
          child: UtilM.loading(),
        ),
      );

  Widget _content() => Scaffold(
        appBar: AppBar(
          title: const Text(StringsManager.addUserAB),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: ListView(
            children: [
              UtilM.box20(),
              imgAvatar(),
              UtilM.box20(),
              fieldsReg(),
              UtilM.box20(),
              saveButt(),
              UtilM.box20(),
            ],
          ),
        ),
      );

  Widget checkInterestState(StateType state) {
    switch (state) {
      case StateType.loading:
        return UtilM.loading();
      case StateType.ok:
        return dropDown(_viewModel.listInter);
      case StateType.fail:
        return UtilM.fail();
    }
  }

  Widget imgAvatar() => SizedBox(
        height: 180,
        child: Column(
          children: [
            InkWell(
              splashColor: Colors.white,
              onTap: () {
                _imageFromGallery();
              },
              child: CircleAvatar(
                  radius: 60,
                  child: StreamBuilder<File>(
                      stream: _viewModel.outputProfilePicture,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return CircleAvatar(
                            radius: 60,
                            child: Image.memory(
                                base64Decode(AppConstants.image404B64)),
                          );
                        } else {
                          return CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(snapshot.data!));
                        }
                      })),
            ),
            UtilM.box15(),
            Text(StringsManager.selectImage,
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      );

  Widget fieldsReg() => Column(
        children: [
          // user name
          StreamBuilder<bool>(
              stream: _viewModel.outputIsUserNameValid,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: userNameCtrl,
                  decoration: InputDecoration(
                    label: const Text(StringsManager.userName),
                    errorText: (snapshot.data ?? true)
                        ? null
                        : StringsManager.userNameError,
                  ),
                );
              }),
          UtilM.box20(),
          // password
          StreamBuilder<bool>(
              stream: _viewModel.outputIsPasswordValid,
              builder: (context, snapshot) {
                return TextField(
                    controller: passwordCtrl,
                    decoration: InputDecoration(
                      errorText: (snapshot.data ?? true)
                          ? null
                          : StringsManager.passwordError,
                      label: const Text(StringsManager.password),
                      suffixIcon: InkWell(
                        onTap: () {
                          isPassword = !isPassword;
                          setState(() {});
                        },
                        child: Icon(
                          isPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: isPassword,
                    enableSuggestions: !isPassword,
                    autocorrect: !isPassword);
              }),
          UtilM.box20(),
          // email
          StreamBuilder<bool?>(
              stream: _viewModel.outputIsEmailValid,
              builder: (context, snapshot) {
                return TextField(
                  controller: emailCtrl,
                  decoration: InputDecoration(
                      errorText: (snapshot.data ?? true)
                          ? null
                          : StringsManager.emailError,
                      label: const Text(StringsManager.email)),
                );
              }),
          UtilM.box20(),
          StreamBuilder<StateType>(
              stream: _viewModel.outputInterestedState,
              builder: (context, snapshot) {
                return checkInterestState(snapshot.data ?? StateType.ok);
              })
        ],
      );

  Widget saveButt() {
    return StreamBuilder<bool>(
        stream: _viewModel.outputAreAllInputsValid,
        builder: (context, snapshot) {
          return UtilM.buttonText(
            text: StringsManager.save,
            onTap: (snapshot.data ?? false)
                ? () {
                    _viewModel.addUser();
                  }
                : null,
          );
        });
  }

  // DropdownButtonFormField
  Widget dropDown(List<InterestModel> values) =>
      DropdownButtonFormField<InterestModel>(
        decoration: const InputDecoration(
          label: Text(StringsManager.assignToUser),
        ),
        items: values
            .map((item) => DropdownMenuItem<InterestModel>(
                  value: item,
                  child: Text(
                    item.intrestText,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: currentInterestModel,
        onChanged: (value) {
          _viewModel.setInterestedId(value?.id ?? "-1");
          setState(() {
            currentInterestModel = value;
          });
        },
        isExpanded: true,
      );

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  // _imageFromCamera() async {
  //   var image = await _imagePicker.pickImage(source: ImageSource.camera);
  //   _viewModel.setProfilePicture(File(image?.path ?? ""));
  // }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
