import 'package:flutter/material.dart';
import 'package:mawqifi/common/color-extension.dart';

class VehicleItem extends StatefulWidget {
  const VehicleItem(
      {super.key,
      required this.brand,
      required this.model,
      required this.plantNo,
      required this.color,
      required this.carTypeId, required this.onTap});

  final String brand;
  final String model;
  final String plantNo;
  final String color;
  final int carTypeId;
  final VoidCallback onTap;

  @override
  State<VehicleItem> createState() => _VehicleItemState();
}

class _VehicleItemState extends State<VehicleItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          border: Border.all(width: 0)
        ),
        child: Row(
          children: [
            (widget.carTypeId == 0)
                ? const SizedBox(
                    width: 80,
                    child: Column(
                      children: [
                        ImageIcon(AssetImage("assets/img/hatchback.png")),
                        Text("Hatchback ")
                      ],
                    ),
                  )
                : (widget.carTypeId == 1)
                    ? const SizedBox(
                        width: 80,
                        child: Column(
                          children: [
                            ImageIcon(AssetImage("assets/img/sedan.png")),
                            Text("Sedan")
                          ],
                        ),
                      )
                    : const SizedBox(
                        width: 80,
                        child: Column(
                          children: [
                            ImageIcon(AssetImage("assets/img/suv.png")),
                            Text("SUV")
                          ],
                        ),
                      ),
            Column(
              children: [
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    TextSpan(
                      text: widget.brand,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: TColor.primaryText),
                    ),
                    TextSpan(
                      text: ' ${widget.model}\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: TColor.primaryText),
                    ),
                    TextSpan(
                      text:
                      widget.plantNo,
                      style: TextStyle(color: TColor.primaryText),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
