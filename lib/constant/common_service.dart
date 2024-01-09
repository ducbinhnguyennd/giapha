import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giapha/constant/colors_const.dart';
import 'package:giapha/constant/double_x.dart';
import 'package:giapha/constant/strings_const.dart';

class CommonService {
  static void showSnackBar(String ms, BuildContext context, Function? callback,
      {String title = StringConst.login}) {
    var snackBar = SnackBar(
      content: Text(ms),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      action: SnackBarAction(
          textColor: ColorConst.colorButtonSnackBarLoginColor,
          label: title,
          onPressed: () {
            // ScaffoldMessenger.of(context).removeCurrentSnackBar();
            callback?.call();
          }),
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showToast(String ms, BuildContext context) {
    // Toast.show(ms, duration: Toast.lengthLong, gravity: Toast.top);

    // showToastNoContextLong(ms);

    _showToastWithContext(context, ms);
  }

  static void showToastLong(String ms, BuildContext context) {
    // Toast.show(ms, duration: Toast.lengthLong, gravity: Toast.top);
  }
  static _showToastWithContext(BuildContext context, String msg) {
    var fToast = FToast();

    if (fToast.context == null) {
      if (kDebugMode) {
        'binhbug_: _showToastWithContext : fToast.context : null';
      }
    }
    fToast.init(context);

    // To remove present showing toast
    fToast.removeCustomToast();

    // To clear the queue
    fToast.removeQueuedCustomToasts();

    Widget toast = Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: DoubleX.kPaddingSizeMedium_1X,
            vertical: DoubleX.kPaddingSizeMedium_1X),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DoubleX.kRadiusSizeGeneric_1XX),
          color: Colors.black87,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Icon(Icons.check),
            // const SizedBox(
            //   width: 12.0,
            // ),
            Flexible(
              child: Text(msg,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: DoubleX.kFontSizeTiny_1X1X)),
            ),
          ],
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );

    // Custom Toast Position
    // fToast.showToast(
    //     child: toast,
    //     toastDuration: Duration(seconds: 2),
    //     positionedToastBuilder: (context, child) {
    //       return Positioned(
    //         child: child,
    //         top: 16.0,
    //         left: 16.0,
    //       );
    //     });
  }

  static showLoading(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
