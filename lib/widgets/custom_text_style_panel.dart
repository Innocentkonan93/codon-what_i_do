import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextStylePanel extends StatelessWidget {
  CustomTextStylePanel({
    Key? key,
  }) : super(key: key);

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
          decoration: const BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.vertical(
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
                  const Text("Taille"),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
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
                            child:
                                SvgPicture.asset("assets/icons/arrow-left.svg"),
                          ),
                          const Expanded(
                            child: SizedBox(
                              child: Center(
                                child: Text("14"),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                                "assets/icons/arrow-right.svg"),
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
