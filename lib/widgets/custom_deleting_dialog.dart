
import 'package:flutter/material.dart';

class CustomDeletingDialog extends StatelessWidget {
  const CustomDeletingDialog({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: double.infinity,
        height: size.height / 2,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Flexible(
                    child: Text(
                      "Êtes-vous sûr ce vouloir supprimer la note ?",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Transform.rotate(
                  angle: -25,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 250,
                    height: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: List.generate(20, (index) {
                            if (index.isOdd) {
                              return Container(
                                width: 3,
                                // color: Colors.blueGrey[900],
                              );
                            }
                            return CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.blueGrey[900],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 0,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text("Non"),
                    onPressed: () {},
                  ),
                  const VerticalDivider(),
                  TextButton(
                    child: Text("Oui"),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
