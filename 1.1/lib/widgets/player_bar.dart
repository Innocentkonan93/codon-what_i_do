
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.56),
        boxShadow: [],
        // gradient: const LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   stops: [0.3, 0.6, 0.9],
        //   colors: [
        //     Colors.black12,
        //     Colors.transparent,
        //     Colors.black12,
        //   ],
        // ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    Text(
                      'Instrumental.mp3',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                const LinearProgressIndicator(
                  value: 1,
                  minHeight: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "0:0",
                      style: TextStyle(fontSize: 9),
                    ),
                    Text(
                      "3:42",
                      style: TextStyle(fontSize: 9),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset('assets/icons/play.svg',
                color: Colors.black),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset('assets/icons/rotate-cw.svg',
                color: Colors.black),
          )
        ],
      ),
    );
  }
}
