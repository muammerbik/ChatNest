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
              "Camera",
              style: TextStyle(fontSize: 20.sp),
            ),
            onPressed: () {
              cameraTapped();
              Navigator.of(context).pop();
            },
          ),
        ),
        Container(
          color: white,
          child: CupertinoActionSheetAction(
            child: Text(
              "Gallery",
              style: TextStyle(fontSize: 20.sp),
            ),
            onPressed: () {
              galleryTapped();
              Navigator.pop(context);
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
        child: Text("Cancel"),
      ),
    );
  }
}
