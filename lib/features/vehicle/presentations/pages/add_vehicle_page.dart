import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common_model/vehicle_model.dart';
import 'package:mawqifi/common_widget/round_button.dart';
import 'package:mawqifi/common_widget/text_field_widget.dart';
import 'package:mawqifi/features/main/presentations/page/main_page.dart';
import 'package:mawqifi/features/vehicle/presentations/cubit/add_vehicle/add_vehicle_cubit.dart';
import 'package:quickalert/quickalert.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage(
      {super.key, required this.isFromProfilePage, this.vehicleModel});

  final bool isFromProfilePage;
  final VehicleModel? vehicleModel;

  static route([VehicleModel? vehicleModel, bool isFromProfilePage = false]) =>
      MaterialPageRoute(
        builder: (context) => AddVehiclePage(
          isFromProfilePage: isFromProfilePage,
          vehicleModel: vehicleModel,
        ),
      );

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController platNoController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  final _brandFormKey = GlobalKey<FormState>();
  final _modelFormKey = GlobalKey<FormState>();
  final _platNoFormKey = GlobalKey<FormState>();
  final _colorFormKey = GlobalKey<FormState>();

  final List<bool> _isCarType = [false, true, false];
  int selectCarTypeId = 1;

  @override
  void initState() {
    if (widget.vehicleModel != null) {
      brandController.text = widget.vehicleModel!.brand;
      modelController.text = widget.vehicleModel!.model;
      platNoController.text = widget.vehicleModel!.plantNo;
      colorController.text = widget.vehicleModel!.color;
      selectCarTypeId = widget.vehicleModel!.carTypeId;
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
          (widget.vehicleModel == null) ? "Add vehicle" : "Update vehicle",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: BlocConsumer<AddVehicleCubit, AddVehicleState>(
        listener: (context, state) {
          if (state is AddVehicleHUDState) {
            Globs.showHUD();
          } else if (state is AddVehicleApiResultState) {
            Globs.hideHUD();
            (widget.isFromProfilePage)
                ? Navigator.pop(context)
                : Navigator.push(context, MainPage.route());
          } else if (state is AddVehicleErrorState) {
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
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    validationKey: _brandFormKey,
                    textInputType: TextInputType.name,
                    hintText: 'BMW',
                    labelText: 'Brand',
                    controller: brandController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Brand is empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                      validationKey: _modelFormKey,
                      textInputType: TextInputType.name,
                      hintText: "ABC",
                      labelText: "Model",
                      controller: modelController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Model is empty";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                      validationKey: _platNoFormKey,
                      textInputType: TextInputType.name,
                      labelText: "Plat No",
                      hintText: "YTP123",
                      controller: platNoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Plat no is empty";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                      validationKey: _colorFormKey,
                      textInputType: TextInputType.name,
                      labelText: "Color",
                      hintText: "White",
                      controller: colorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Color is empty";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Car type",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      ToggleButtons(
                        isSelected: _isCarType,
                        onPressed: (int index) {
                          selectCarTypeId = index;
                          setState(() {
                            for (int i = 0; i < _isCarType.length; i++) {
                              _isCarType[i] = i == index;
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
                              children: [
                                ImageIcon(
                                    AssetImage("assets/img/hatchback.png")),
                                Text("Hatchback ")
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                ImageIcon(AssetImage("assets/img/sedan.png")),
                                Text("Sedan")
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                ImageIcon(AssetImage("assets/img/suv.png")),
                                Text("SUV")
                              ],
                            ),
                          ),
                        ],
                        // endregion
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RoundButton(
                    titleColor: TColor.primaryTextW,
                    backgroundColor: TColor.primary,
                    title: "Register",
                    onPressed: () {
                      if (_brandFormKey.currentState!.validate() &&
                          _modelFormKey.currentState!.validate() &&
                          _platNoFormKey.currentState!.validate() &&
                          _colorFormKey.currentState!.validate()) {
                        context.read<AddVehicleCubit>().addVehicleSubmit(
                            brandController.text,
                            modelController.text,
                            platNoController.text,
                            colorController.text,
                            selectCarTypeId,
                            widget.vehicleModel?.id);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
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
