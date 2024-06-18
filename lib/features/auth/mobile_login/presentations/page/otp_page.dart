import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common_widget/round_button.dart';
import 'package:mawqifi/features/auth/mobile_login/presentations/cubit/otp/otp_cubit.dart';
import 'package:mawqifi/features/proflie/presentations/pages/create_profile_page.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:quickalert/quickalert.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key, required this.phoneNumber});

  final String phoneNumber;

  static route(String phoneNumber) => MaterialPageRoute(
        builder: (context) => OTPPage(
          phoneNumber: phoneNumber,
        ),
      );

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  final OtpTimerButtonController _otpTimeController =
      OtpTimerButtonController();
  late var _otp = "";

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
          "OTP Verification",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpHUDState) {
            Globs.showHUD();
          } else if (state is ResendOtpApiResultState) {
            Globs.hideHUD();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.info,
              title: 'We send to you again',
              text: "Sorry for that but please waiting for sometime, maybe the sms in the way to you",
              backgroundColor: Colors.black,
              titleColor: Colors.white,
              textColor: Colors.white,
            );
          } else if (state is OtpErrorState) {
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
          } else if (state is OtpApiResultState){
            Globs.hideHUD();
            Navigator.push(context, CreateProfilePage.route(widget.phoneNumber));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Enter the 4-digit code send to you at \n',
                      style: TextStyle(color: TColor.primaryText),
                    ),
                    TextSpan(
                      text: '${widget.phoneNumber} ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: TColor.primaryText,
                      ),
                    ),
                    TextSpan(
                        text: 'Edit',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                OtpPinField(
                  key: _otpPinFieldController,
                  textInputAction: TextInputAction.done,
                  maxLength: 4,
                  fieldWidth: 40,
                  onSubmit: (text) {
                    _otp = text.toString().trim();
                  },
                  onChange: (text) {},
                ),
                const SizedBox(
                  height: 15,
                ),
                const Spacer(),
                RoundButton(
                  titleColor: TColor.primaryTextW,
                  backgroundColor: TColor.primary,
                  title: "Continue",
                  onPressed: () {
                    context
                        .read<OtpCubit>()
                        .otpSubmit(widget.phoneNumber, _otp);
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
                OtpTimerButton(
                  height: 60,
                  onPressed: () {
                    context.read<OtpCubit>().resendOtp(widget.phoneNumber);
                  },
                  text: Text(
                    'Resend OTP',
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 16,
                    ),
                  ),
                  buttonType: ButtonType.text_button,
                  backgroundColor: Colors.orange,
                  duration: 60,
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
