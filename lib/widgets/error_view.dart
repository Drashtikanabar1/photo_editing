import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(
      {Key? key,
      required this.error,
      this.onRetry,
      this.showRetry = false,
      this.btnText})
      : super(key: key);
  final String error;
  final bool showRetry;
  final Function()? onRetry;
  final String? btnText;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.w, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30.w,
            ),
            if (showRetry)
              ElevatedButton(
                onPressed: () {
                  if (onRetry != null) onRetry!();
                },
                child: Text(btnText ?? "Retry"),
              )
          ],
        ),
      )),
    );
  }
}
