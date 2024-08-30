import 'dart:math';

import 'package:flutter/material.dart';

import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class checkScreen extends StatefulWidget {
  const checkScreen({super.key, required this.room, required this.username});
  final String room, username;

  @override
  State<checkScreen> createState() => _checkScreenState();
}

class _checkScreenState extends State<checkScreen> {
  final userId = Random().nextInt(10000).toString();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('room: ${widget.room}');
  }
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltVideoConference(
        appID: 1060386117,
        appSign:
            "b820059887d23b8e40dd10d7ccea944b16b37073b28ec7547132e1ce38b857e0",
        conferenceID: widget.room,
        userID: userId,
        userName: widget.username,
        config: ZegoUIKitPrebuiltVideoConferenceConfig());
  }
}
