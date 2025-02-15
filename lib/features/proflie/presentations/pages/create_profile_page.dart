import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common_widget/round_button.dart';
import 'package:mawqifi/common_widget/text_field_widget.dart';
import 'package:mawqifi/features/proflie/presentations/cubit/create_profile/create_profile_cubit.dart';
import 'package:mawqifi/features/vehicle/presentations/pages/add_vehicle_page.dart';
import 'package:quickalert/quickalert.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage(
      {super.key, required this.phoneNumber, required this.isUpdate});

  final String phoneNumber;
  final bool isUpdate;

  static route(String phoneNumber, [bool isUpdate = false]) =>
      MaterialPageRoute(
        builder: (context) => CreateProfilePage(
          phoneNumber: phoneNumber,
          isUpdate: isUpdate,
        ),
      );

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final List<bool> _isGender = [false, true];
  int selectGender = 1;
  final _fullNameFormKey = GlobalKey<FormState>();
  final _homeAddressFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final homeAddressController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate) {
      selectGender = Globs.udValueInt(PreferenceKey.genderTypeId);
      fullNameController.text = Globs.udValueString(PreferenceKey.fullName);
      homeAddressController.text =
          Globs.udValueString(PreferenceKey.homeAddress);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        title: Text(
          (widget.isUpdate) ? "Update Profile" : "Create profile",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: BlocConsumer<CreateProfileCubit, CreateProfileState>(
        listener: (context, state) {
          if (state is CreateProfileHUDState) {
            Globs.showHUD();
          } else if (state is CreateProfileApiResultState) {
            Globs.hideHUD();
            if (kDebugMode) {
              print(state.profileModel);
            }
            Globs.udStringSet(
                state.profileModel.fullName, PreferenceKey.fullName);
            Globs.udStringSet(
                state.profileModel.phoneNumber, PreferenceKey.phoneNumber);
            Globs.udStringSet(
                state.profileModel.homeAddress, PreferenceKey.homeAddress);
            Globs.udIntSet(
                state.profileModel.genderTypeId, PreferenceKey.genderTypeId);
            Globs.udBoolSet(true, PreferenceKey.userLogin);
            Globs.udIntSet(state.profileModel.userId, PreferenceKey.userId);
            if (widget.isUpdate) {
              Navigator.pop(context);
            } else {
              Navigator.push(context, AddVehiclePage.route());
            }
          } else if (state is CreateProfileErrorState) {
            Globs.hideHUD();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error',
              text: state.errorMessage,
              backgroundColor: Colors.black,
              titleColor: Colors.white,
              textColor: Colors.white,
            );
          }else if (state is CreateProfileErrorApiResultState) {
            Globs.hideHUD();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: state.errorResponse.statusCode.toString(),
              text: state.errorResponse.message,
              backgroundColor: Colors.black,
              titleColor: Colors.white,
              textColor: Colors.white,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    validationKey: _fullNameFormKey,
                    textInputType: TextInputType.name,
                    hintText: 'John Smith',
                    labelText: 'Full name',
                    validator: (p0) {
                      if (p0 == null || p0.length < 6) {
                        return "Please Enter you full name";
                      }
                      return null;
                    },
                    controller: fullNameController,
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    validationKey: _homeAddressFormKey,
                    textInputType: TextInputType.streetAddress,
                    hintText: "2929 Rayhanah Bint Zaid",
                    labelText: "Home Address",
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "Please Enter you home address";
                      }
                      return null;
                    },
                    controller: homeAddressController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Gander",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      ToggleButtons(
                        isSelected: _isGender,
                        onPressed: (int index) {
                          selectGender = index;
                          setState(() {
                            for (int i = 0; i < _isGender.length; i++) {
                              _isGender[i] = i == index;
                            }
                          });
                        },
                        borderColor: TColor.secondary,
                        selectedBorderColor: TColor.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        children: const <Widget>[
                          SizedBox(
                            width: 80,
                            child: Column(
                              children: [Icon(Icons.female), Text("Female")],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Column(
                              children: [Icon(Icons.male), Text("Male")],
                            ),
                          ),
                        ],
                        // endregion
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundButton(
                    titleColor: TColor.primaryTextW,
                    backgroundColor: TColor.primary,
                    title: "Next",
                    onPressed: () {
                      print( _fullNameFormKey.currentState!.validate());
                      if (_homeAddressFormKey.currentState!.validate() &&
                          _fullNameFormKey.currentState!.validate()) {
                        context.read<CreateProfileCubit>().profileSubmit(
                            widget.phoneNumber,
                            fullNameController.text,
                            homeAddressController.text,
                            selectGender);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
