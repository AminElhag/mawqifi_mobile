import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common_widget/round_button.dart';
import 'package:mawqifi/features/auth/mobile_login/presentations/cubit/mobile_login/mobile_login_cubit.dart';
import 'package:mawqifi/features/auth/mobile_login/presentations/page/otp_page.dart';
import 'package:quickalert/quickalert.dart';

class MobileNumberPage extends StatefulWidget {
  const MobileNumberPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const MobileNumberPage(),
      );

  @override
  State<MobileNumberPage> createState() => _MobileNumberPageState();
}

class _MobileNumberPageState extends State<MobileNumberPage> {
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isValidNumber = false;
  PhoneNumber? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter Mobile Number",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<MobileLoginCubit, MobileLoginState>(
        listener: (context, state) {
          if (state is MobileLoginHUDState) {
            Globs.showHUD();
          } else if (state is MobileLoginApiResultState) {
            Globs.hideHUD();
            Navigator.push(context, OTPPage.route(phoneNumber!.completeNumber));
          } else if (state is MobileLoginErrorState) {
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
          } else if (state is MobileLoginErrorApiResultState) {
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
            child: Column(
              children: [
                Center(
                  child: Text(
                    "We need to verify your phone number.",
                    style: TextStyle(color: TColor.primaryText),
                  ),
                ),
                Center(
                  child: Text(
                    "Carrier charge may apply.",
                    style: TextStyle(color: TColor.primaryText),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: IntlPhoneField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          )),
                    ),
                    initialCountryCode: 'SA',
                    onChanged: (value) {
                      if (value.number.isNotEmpty && value.isValidNumber()) {
                        isValidNumber = true;
                        phoneNumber = value;
                      } else {
                        isValidNumber = false;
                      }
                    },
                    onCountryChanged: (value) {
                      isValidNumber = false;
                      _formKey.currentState?.reset();
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Spacer(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          'By continuing, I confirm that I have read & agree to the \n',
                      style: TextStyle(color: TColor.primaryText),
                    ),
                    TextSpan(
                      text: 'Terms & conditions ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: TColor.primaryText),
                    ),
                    TextSpan(
                        text: 'and ',
                        style: TextStyle(color: TColor.primaryText)),
                    TextSpan(
                      text: 'Privacy policy',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: TColor.primaryText),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                RoundButton(
                  titleColor: TColor.primaryTextW,
                  backgroundColor: TColor.primary,
                  title: "Continue",
                  onPressed: () {
                    if (isValidNumber) {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          if (phoneNumber != null) {
                            context
                                .read<MobileLoginCubit>()
                                .phoneNumberLogin(phoneNumber!.completeNumber);
                          }
                        }
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
