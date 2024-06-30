import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common_model/vehicle_model.dart';
import 'package:mawqifi/common_widget/vehicle_item.dart';
import 'package:mawqifi/features/vehicle/presentations/cubit/vehicle_list/vehicle_list_cubit.dart';
import 'package:mawqifi/features/vehicle/presentations/pages/add_vehicle_page.dart';
import 'package:quickalert/quickalert.dart';

class VehicleList extends StatefulWidget {
  const VehicleList({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const VehicleList(),
      );

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  final List<VehicleModel> apiList = [];

  @override
  void initState() {
    context
        .read<VehicleListCubit>()
        .getVehiclesList(Globs.udValueInt(PreferenceKey.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My vehicles",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColor.primary,
        tooltip: 'Add New Vehicle',
        onPressed: () {
          Navigator.push(context, AddVehiclePage.route(null, true));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: BlocConsumer<VehicleListCubit, VehicleListState>(
        listener: (context, state) {
          if (state is VehicleListHUDState) {
            Globs.showHUD();
          } else if (state is VehicleListErrorState) {
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
          } else if (state is VehicleListErrorApiResultState) {
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
          } else if (state is VehicleListApiResultState) {
            Globs.hideHUD();
            apiList.clear();
            apiList.addAll(state.items);
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: context.height - 330,
            child: ListView.builder(
              itemCount: apiList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = apiList[index];
                return VehicleItem(
                  onTap: () {
                    Navigator.push(context, AddVehiclePage.route(item, true));
                  },
                  color: item.color,
                  brand: item.brand,
                  carTypeId: item.carTypeId,
                  model: item.model,
                  plantNo: item.plantNo,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
