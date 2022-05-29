import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextStylePanel extends StatelessWidget {
  CustomTextStylePanel({
    required this.textStyle,
    required this.textAlign,
    Key? key,
  }) : super(key: key);
  final TextStyle textStyle;
  final TextAlign textAlign;
  List<String> textStyleIcon = [
    
    "assets/icons/align-center.svg",
    "assets/icons/align-justify.svg",
    "assets/icons/align-right.svg",
    "assets/icons/align-left.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 3,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white54,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Taille de police",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0XFFBEBEBE).withOpacity(0.25),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/icons/arrow-left.svg",
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Center(
                                child: Text(
                                  textStyle.fontSize.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/icons/arrow-right.svg",
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: textStyleIcon
                    .map((icon) => SvgPicture.asset(
                          icon,
                          color: Colors.white,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Appliquer'),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  elevation: 3,
                  minimumSize: const Size(125, 30),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
