import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common_widget/booking_progress_button.dart';

class BookingItem extends StatefulWidget {
  const BookingItem(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.details,
      required this.price,
      required this.onPressed,
      required this.startTime,
      required this.endTime,
      required this.statusId});

  final int statusId;
  final String imageUrl, name, details;
  final VoidCallback onPressed;
  final double price;
  final String startTime, endTime;

  @override
  State<BookingItem> createState() => _BookingItemState();
}

class _BookingItemState extends State<BookingItem> {
  String form = "";
  String until = "";
  String howMuch = "";

  @override
  void initState() {
    var hour = DateTime.parse(widget.startTime).toLocal().hour;
    var minute = DateTime.parse(widget.startTime).toLocal().minute;
    if (hour > 12) {
      hour = hour - 12;
      form = "$hour:$minute PM";
    } else {
      form = "$hour:$minute AM";
    }
    hour =DateTime.parse(widget.endTime).toLocal().hour;
    minute = DateTime.parse(widget.endTime).toLocal().minute;
    if (hour > 12) {
      hour = hour - 12;
      until = "$hour:$minute PM";
    } else {
      until = "$hour:$minute AM";
    }
    howMuch = "${DateTime.parse(widget.endTime).difference(DateTime.parse(widget.startTime)).inHours}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  height: 70,width: 70,
                  imageUrl: widget.imageUrl,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/img/pictures_error.png",
                    height: 70,
                    width: 70,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: context.width - 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.width - 150,
                      child: Text(
                        widget.details,
                        maxLines: 2,
                        style: TextStyle(
                            color: TColor.secondaryText, fontSize: 12),
                      ),
                    ),
                    Text(
                      "\$ ${widget.price}/hour",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  form,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 12),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text("● - - - - - - - - - - - - - - ●"),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  until,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ],
            ),
            Text(
              "$howMuch hours",
              maxLines: 2,
              style: TextStyle(color: TColor.secondaryText, fontSize: 12),
            ),
            BookingProgressButton(onPressed: () {}, statusId: widget.statusId)
          ],
        ),
      ),
    );
  }
}
