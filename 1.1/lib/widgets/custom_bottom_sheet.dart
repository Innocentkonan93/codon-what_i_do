
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 49,
      color: Colors.white,
      width: double.infinity,
      child: Row(
        children: [
          const Text(
            'Aa',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Container(
                height: 12,
                width: 12,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all()),
              );
            }),
          )),
          const Icon(Icons.keyboard)
        ],
      ),
    );
  }
}
