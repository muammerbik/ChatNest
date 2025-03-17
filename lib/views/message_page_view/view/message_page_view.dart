// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:chat_menager/bloc/message_bloc/message_bloc.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/components/custom_textFormField/custom_textForm_Field.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
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
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
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
              radius: 20,
              backgroundColor: Colors.grey.withAlpha(30),
              backgroundImage:
                  widget.sohbetEdilenUser.profileUrl?.isNotEmpty ?? false
                      ? NetworkImage(widget.sohbetEdilenUser.profileUrl!)
                      : const AssetImage("assets/icons/user_avatar.png")
                          as ImageProvider,
            ),
            const SizedBox(width: 12),
            TextWidgets(
              text: widget.sohbetEdilenUser.userName ?? '',
              size: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          image: DecorationImage(
            image: AssetImage("assets/images/message_background.jpg"),
            fit: BoxFit.cover,
            opacity: 0.8, // Adjust opacity to ensure text is readable
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
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 8 : 20,
                left: 16,
                right: 8,
                top: 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: _textEditingController,
                      hintText: 'Mesaj',
                      cursorColor: Colors.green,
                    ),
                  ),
                  Container(
                    height: 45.h,
                    width: 45.h,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.send,
                        size: 22.sp,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_textEditingController.text.trim().isNotEmpty) {
                          debugPrint(
                              "Current User ID: ${widget.currentUser.userId}");
                          debugPrint(
                              "Sohbet Edilen User ID: ${widget.sohbetEdilenUser.userId}");

                          final kaydedilecekMesaj = MesajModel(
                            kimden: widget.currentUser.userId,
                            kime: widget.sohbetEdilenUser.userId,
                            bendenMi: true,
                            mesaj: _textEditingController.text.trim(),
                            date: Timestamp.now(),
                          );

                          debugPrint(
                              "Kaydedilecek Mesaj: ${kaydedilecekMesaj.toString()}");

                          context.read<MessageBloc>().add(
                                SaveMessageEvent(
                                    kaydedilecekMesaj: kaydedilecekMesaj),
                              );

                          _textEditingController.clear();
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
    Color messageSender = Colors.white;
    Color messageField = Colors.green.shade600;
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
                    color: Colors.grey.withOpacity(0.2),
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
                      style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      timeAndMinuteValue,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade600,
                      ),
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
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage:
                            NetworkImage(widget.sohbetEdilenUser.profileUrl!),
                      )
                    : CircleAvatar(
                        radius: 16.r,
                        backgroundColor: Colors.grey.withAlpha(30),
                        backgroundImage: const AssetImage(
                          "assets/icons/user_avatar.png",
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
                          Text(
                            timeAndMinuteValue,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.white70,
                            ),
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
