import 'package:flutter/material.dart';

class NothingToShowWidget extends StatelessWidget {
  const NothingToShowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Image.asset("assets/img/planet.png",width: 200,height: 200,),
          SizedBox(height: 6,),
          Text("Nothing to show here"),
          const Spacer(),
        ],
      ),
    );
  }
}
