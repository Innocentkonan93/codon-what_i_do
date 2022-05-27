

import 'package:flutter/material.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({
    Key? key,
    required this.isGrid,
  }) : super(key: key);

  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: !isGrid
            ? const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
                mainAxisExtent: 200
                // childAspectRatio: 0.8,
                )
            : const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
                mainAxisExtent: 200
                // childAspectRatio: 0.8,
                ),
        padding: const EdgeInsets.all(8),
        itemCount: 30,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.green,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: isGrid
                        ? List.generate(17, (index) {
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
                          })
                        : List.generate(30, (index) {
                            if (index.isOdd) {
                              return Container(
                                width: 3,
                                // color: Colors.blueGrey[900],
                              );
                            }
                            return CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.blueGrey[900],
                            );
                          }),
                  ),
                ),
                Text(
                  index.toString(),
                ),
                const Expanded(
                  child: Text(""),
                ),
                Container(
                  width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0XFFACACAC).withOpacity(0.15),
                          const Color(0XFF050505).withOpacity(0.25)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
