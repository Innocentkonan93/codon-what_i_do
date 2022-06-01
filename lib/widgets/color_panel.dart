import 'package:flutter/material.dart';

class ColorPanel extends StatelessWidget {
  const ColorPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> sheetColors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiary,
    ];
    Map<String, dynamic> panelColors = {
      "primary": {
        "code": "0XFF1ba9c3",
        "color": Theme.of(context).colorScheme.primary,
      },
      "secondary": {
        "code": "0XFFfdbf17",
        "color": Theme.of(context).colorScheme.secondary,
      },
      "tertiary": {
        "code": "0XFFf39591",
        "color": Theme.of(context).colorScheme.tertiary,
      },
    };

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      height: 200,
      child: Column(
        children: [
          Text(
            'Couleur de la feuille',
            style: Theme.of(context).textTheme.headline5,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...panelColors.entries.map((color) {
                  return GestureDetector(
                    onTap: () async {
                      Navigator.pop(context, color.value["code"]);
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.value["color"],
                      ),
                    ),
                  );
                })
              ],

              // List.generate(sheetColors.length, (index) {
              //   return GestureDetector(
              //     onTap: () async {},
              //     child: Container(
              //       height: 45,
              //       width: 45,
              //       margin: const EdgeInsets.symmetric(horizontal: 15),
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: sheetColors[index],
              //       ),
              //     ),
              //   );
              // }),
            ),
          ),
        ],
      ),
    );
  }
}
