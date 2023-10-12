import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ToastHelper {
  static FToast fToast = FToast();

  static showTost(String message, ToastType type, BuildContext context) {
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color:
            type == ToastType.SUCCESS ? Colors.greenAccent : Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            type == ToastType.SUCCESS ? Icons.check : Icons.error,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Container(
              child: child,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.8));
        });
  }
}

enum ToastType { SUCCESS, ERROR }
