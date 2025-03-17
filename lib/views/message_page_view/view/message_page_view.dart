// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_menager/constants/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:chat_menager/bloc/message_bloc/message_bloc.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/components/custom_textFormField/custom_textForm_Field.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/core/model/mesaj_model.dart';
import 'package:chat_menager/core/model/user_model.dart';

class MessagePageView extends StatefulWidget {
  final UserModel currentUser;
  final UserModel sohbetEdilenUser;
  final List<MesajModel> messageList;

  const MessagePageView({
    Key? key,
    required this.currentUser,
    required this.sohbetEdilenUser,
    required this.messageList,
  }) : super(key: key);

  @override
  State<MessagePageView> createState() => _MessagePageViewState();
}

class _MessagePageViewState extends State<MessagePageView> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leadingWidth: 30,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: () => Navigation.ofPop(),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.h,
              backgroundColor: white,
              backgroundImage:
                  widget.sohbetEdilenUser.profileUrl?.isNotEmpty ?? false
                      ? NetworkImage(widget.sohbetEdilenUser.profileUrl!)
                      : const AssetImage(userImage) as ImageProvider,
            ),
            SizedBox(width: 12.w),
            TextWidgets(
              text: widget.sohbetEdilenUser.userName ?? '',
              size: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: grey50,
          image: DecorationImage(
            image: AssetImage(messagePageBackGroundImage),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                itemCount: widget.messageList.length,
                itemBuilder: (context, index) {
                  final mesaj =
                      widget.messageList[widget.messageList.length - 1 - index];
                  return konusmaBalonlari(mesaj);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: transparent,
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 8 : 20,
                left: 16,
                right: 8,
                top: 6,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: messageController,
                      hintText: messageText,
                    ),
                  ),
                  Container(
                    height: 52.h,
                    width: 52.h,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      elevation: 0,
                      backgroundColor: green,
                      child: Icon(
                        Icons.send,
                        size: 22.sp,
                        color: white,
                      ),
                      onPressed: () {
                        if (messageController.text.trim().isNotEmpty) {
                          debugPrint(
                              "Current User ID: ${widget.currentUser.userId}");
                          debugPrint(
                              "Sohbet Edilen User ID: ${widget.sohbetEdilenUser.userId}");

                          final kaydedilecekMesaj = MesajModel(
                            kimden: widget.currentUser.userId,
                            kime: widget.sohbetEdilenUser.userId,
                            bendenMi: true,
                            mesaj: messageController.text.trim(),
                            date: Timestamp.now(),
                          );

                          debugPrint(
                              "Kaydedilecek Mesaj: ${kaydedilecekMesaj.toString()}");

                          context.read<MessageBloc>().add(
                                SaveMessageEvent(
                                    kaydedilecekMesaj: kaydedilecekMesaj),
                              );

                          messageController.clear();
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget konusmaBalonlari(MesajModel oankiMesaj) {
    Color messageSender = white;
    Color messageField = green.shade600;
    var fromMe = oankiMesaj.kimden == widget.currentUser.userId;

    var timeAndMinuteValue = "";
    try {
      timeAndMinuteValue =
          showTimeAndMinute(oankiMesaj.date ?? Timestamp(1, 1));
    } catch (e) {
      debugPrint("mesaj gönderimde zaman hatası var $e");
    }

    if (fromMe) {
      return Padding(
        padding: EdgeInsets.only(
          left: 60.w,
          right: 8.w,
          top: 8.h,
          bottom: 8.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: messageSender.withOpacity(0.95),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(4.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      oankiMesaj.mesaj,
                      style: TextStyle(fontSize: 16.sp, color: black87),
                    ),
                    SizedBox(height: 4.h),
                    TextWidgets(
                      text: timeAndMinuteValue,
                      size: 11.sp,
                      color: black54,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
          left: 8.w,
          right: 60.w,
          top: 8.h,
          bottom: 8.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                widget.sohbetEdilenUser.profileUrl?.isNotEmpty ?? false
                    ? CircleAvatar(
                        radius: 16.r,
                        backgroundColor: grey50,
                        backgroundImage:
                            NetworkImage(widget.sohbetEdilenUser.profileUrl!),
                      )
                    : CircleAvatar(
                        radius: 16.r,
                        backgroundColor: white,
                        backgroundImage: const AssetImage(
                          userImage,
                        ),
                      ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: messageField.withOpacity(0.95),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(4.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            oankiMesaj.mesaj,
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                          SizedBox(height: 4.h),
                          TextWidgets(
                            text: timeAndMinuteValue,
                            size: 11.sp,
                            color: white70,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  String showTimeAndMinute(Timestamp? date) {
    final formatter = DateFormat.Hm();
    return formatter.format(date!.toDate());
  }
}
