import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';
import 'package:mawqifi/common_widget/booking_progress_button.dart';

class BookingItem extends StatefulWidget {
  const BookingItem(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.distance,
      required this.details,
      required this.price,
      required this.onPressed,
      required this.startTime,
      required this.endTime,
      required this.statusId});

  final int statusId;
  final String imageUrl, name, distance, details, price, startTime, endTime;
  final VoidCallback onPressed;

  @override
  State<BookingItem> createState() => _BookingItemState();
}

class _BookingItemState extends State<BookingItem> {
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
                Image.asset(
                  widget.imageUrl,
                  height: 70,
                  width: 70,
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
                          Text(
                            widget.distance,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 10),
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
                      widget.price,
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
                  widget.startTime,
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
                  widget.endTime,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ],
            ),
            Text(
              "2 hours",
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
