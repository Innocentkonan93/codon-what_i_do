import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({
    required this.sheetColor,
    Key? key,
  }) : super(key: key);

  Color sheetColor;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    List<Color> sheetColors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 49,
      color: Colors.white12,
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
            children: List.generate(sheetColors.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.sheetColor = sheetColors[index];
                  });
                },
                child: Container(
                  height: 15,
                  width: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: sheetColors[index],
                      border: widget.sheetColor == sheetColors[index]
                          ? Border.all()
                          : null),
                ),
              );
            }),
          )),
          const Icon(Icons.keyboard)
        ],
      ),
    );
  }
}
