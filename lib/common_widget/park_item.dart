import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';

class ParkItem extends StatefulWidget {
  const ParkItem(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.details,
      required this.price,
      required this.onPressed});

  final String name, details;
  final String? imageUrl;
  final double price;
  final VoidCallback onPressed;

  @override
  State<ParkItem> createState() => _ParkItemState();
}

class _ParkItemState extends State<ParkItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.onPressed,
        child: Row(
          children: [
            CachedNetworkImage(
              height: 70,width: 70,
              imageUrl: widget.imageUrl?? "",
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
                    style: TextStyle(color: TColor.secondaryText, fontSize: 12),
                  ),
                ),
                Text(
                  "${widget.price}\$",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
