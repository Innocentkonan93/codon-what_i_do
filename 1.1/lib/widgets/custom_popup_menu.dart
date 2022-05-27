
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomPopuMenu extends StatelessWidget {
  const CustomPopuMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Row(
              children: const [
                Text('Aa'),
                SizedBox(width: 25),
                Expanded(child: Text("Modifier la police"))
              ],
            ),
          ),
          PopupMenuItem(
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/share-2.svg",
                    color: Colors.white),
                const SizedBox(width: 25),
                const Expanded(child: Text("Partager la note"))
              ],
            ),
          ),
          PopupMenuItem(
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/clock.svg",
                    color: Colors.white),
                const SizedBox(width: 25),
                const Text("Ajouter un rappel")
              ],
            ),
          ),
          PopupMenuItem(
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/trash-2.svg",
                    color: Colors.white),
                const SizedBox(width: 25),
                const Expanded(child: Text("Supprimer la note"))
              ],
            ),
          ),
        ];
      },
      offset: const Offset(-15, 40),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      color: Colors.black38,
    );
  }
}
