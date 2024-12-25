import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showCustomToast(BuildContext context, String title) {
  FToast ftoast = FToast();
  ftoast.init(context);
  Widget toast = Container(
    // width: 100,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onSurface),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Container(
        //   padding: EdgeInsets.only(bottom: 10),
        //   child: Image.asset(assets.metamedia, height: 40,width: 40,)),
        Flexible(
            child: Text(
          softWrap: true,
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        )),
      ],
    ),
  );
  ftoast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    positionedToastBuilder: (context, child, gravity) {
      return Positioned(
        bottom: 100.0, // Adjust this value to control vertical position
        left: 20.0, // Adjust this value to control horizontal position
        right:
            20.0, // Adjust this value if you want some padding on the right side
        child: child,
      );
    },
    // positionedToastBuilder: (context, child) {
    //   return Positioned(
    //     bottom: 100.0, // Adjust this value to control vertical position
    //     left: 20.0, // Adjust this value to control horizontal position
    //     right:
    //         20.0, // Adjust this value if you want some padding on the right side
    //     child: child,
    //   );
    // },
    toastDuration: const Duration(seconds: 5),
  );
}
