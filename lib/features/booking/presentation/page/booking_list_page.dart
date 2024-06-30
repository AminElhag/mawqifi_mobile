import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common/globs.dart';
import 'package:mawqifi/common_model/booking_item_model.dart';
import 'package:mawqifi/common_widget/booking_item.dart';
import 'package:mawqifi/features/booking/presentation/cubit/booking_list/booking_list_cubit.dart';
import 'package:quickalert/quickalert.dart';

class BookingListPage extends StatefulWidget {
  const BookingListPage({super.key});

  static route() =>
      MaterialPageRoute(
        builder: (context) => const BookingListPage(),
      );

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  final List<BookingItemModel> items = [];

  @override
  void initState() {
    context.read<BookingListCubit>().getBookingList(
        Globs.udValueInt(PreferenceKey.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: BlocConsumer<BookingListCubit, BookingListState>(
        listener: (context, state) {
          if (state is BookingListHUDState) {
            Globs.showHUD();
          } else if (state is BookingListErrorState) {
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
          } else if (state is BookingListErrorApiResultState) {
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
          } else if (state is BookingListGetListApiResultState) {
            Globs.hideHUD();
            items.clear();
            items.addAll(state.items);
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: context.height - 210,
                child: ListView.builder(
                  itemCount: items.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = items[index];
                    return BookingItem(
                      imageUrl: item.imageUrl,
                      name: item.name,
                      details: item.longAddress,
                      price: item.price,
                      startTime: item.from,
                      endTime: item.until,
                      statusId: item.statusId as int? ?? 2,
                      onPressed: () {},
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
