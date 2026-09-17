import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/extensions/extensions.dart';
import 'package:igenius/core/utils/url_launcher_utils.dart';

import '../../../../../core/resources/styles_manager.dart';

class MeetingButton extends StatelessWidget {
  const MeetingButton({Key? key, required this.meetingUrl}) : super(key: key);
  final String meetingUrl;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        UrlLauncherUtils.openLink(meetingUrl);
      },
      child: Container(
        margin: 20.rPadding,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurple,
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 15.r,
            ),
                        Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Join Live Meeting',
                  style: AppsStyles.s12Bold.copyWith(color: Colors.white),
                ),
                Text(
                  'Tap to start the live session now',
                  style: AppsStyles.s12Regular.copyWith(color: Colors.white),
                ),
              ],
            ),
            10.horizontalSpace,

                                                Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              height: 40.r,
              width: 40.r,
              child: Icon(
                Icons.play_arrow_outlined,
                color: Colors.deepPurple,
                size: 30.r,
              ),
            ),



          ],
        ),
      ),
    );
  }
}
