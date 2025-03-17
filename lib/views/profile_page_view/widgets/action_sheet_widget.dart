import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionSheet extends StatelessWidget {
  final VoidCallback cameraTapped;
  final VoidCallback galleryTapped;

  const ActionSheet({
    super.key,
    required this.cameraTapped,
    required this.galleryTapped,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: <Widget>[
        Container(
          color: white,
          child: CupertinoActionSheetAction(
            child: Text(
              camera,
              style: TextStyle(fontSize: 20.sp),
            ),
            onPressed: () {
              cameraTapped();
              Navigation.ofPop();
            },
          ),
        ),
        Container(
          color: white,
          child: CupertinoActionSheetAction(
            child: Text(
              gallery,
              style: TextStyle(fontSize: 20.sp),
            ),
            onPressed: () {
              galleryTapped();
              Navigation.ofPop();
            },
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDestructiveAction: true,
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(cancel),
      ),
    );
  }
}
