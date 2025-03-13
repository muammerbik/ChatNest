import 'package:chat_menager/constants/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_menager/bloc/message_bloc/message_bloc.dart';
import 'package:chat_menager/core/model/mesaj_model.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/components/custom_textFormField/custom_textForm_Field.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagePageView extends StatefulWidget {
  final UserModel currentUser;
  final UserModel sohbetEdilenUser;

  const MessagePageView({
    Key? key,
    required this.currentUser,
    required this.sohbetEdilenUser,
  }) : super(key: key);

  @override
  State<MessagePageView> createState() => _MessagePageViewState();
}

class _MessagePageViewState extends State<MessagePageView> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MessageBloc>().add(GetMessageEvent(
          currentUserId: widget.currentUser.userId,
          sohbetEdilenUserId: widget.sohbetEdilenUser.userId,
        ));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 16,
        leading: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.withAlpha(30),
              backgroundImage:
                  NetworkImage(widget.sohbetEdilenUser.profileUrl!),
            ),
            const SizedBox(width: 6),
            TextWidgets(
              text: widget.sohbetEdilenUser.userName ?? 'Bilinmeyen Kullanıcı',
              size: 18,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
      body: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: state.messageList.length,
                  itemBuilder: (context, index) {
                    final mesaj =
                        state.messageList[state.messageList.length - 1 - index];
                    return konusmaBalonlari(mesaj);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: 72,
                  padding: const EdgeInsets.only(bottom: 12, left: 10, top: 12),
                  color: Colors.transparent,
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
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 0,
                            backgroundColor: Colors.green,
                            child: const Icon(
                              Icons.send,
                              size: 25,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (_textEditingController.text
                                  .trim()
                                  .isNotEmpty) {
                                debugPrint("Current User ID: ${widget.currentUser.userId}");
                                debugPrint("Sohbet Edilen User ID: ${widget.sohbetEdilenUser.userId}");
                                
                                final kaydedilecekMesaj = MesajModel(
                                  kimden: widget.currentUser.userId,
                                  kime: widget.sohbetEdilenUser.userId,
                                  bendenMi: true,
                                  mesaj: _textEditingController.text.trim(),
                                  date: Timestamp.now(),
                                );

                                debugPrint("Kaydedilecek Mesaj: ${kaydedilecekMesaj.toString()}");

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
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget konusmaBalonlari(MesajModel oankiMesaj) {
    Color messageSender = purple;
    Color messageField = indigo;
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
          left: 45.w,
          right: 8.w,
          top: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: messageSender,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Text(
                        oankiMesaj.mesaj,
                        style: TextStyle(fontSize: 17.sp, color: white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(timeAndMinuteValue),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: grey.shade200,
                  backgroundImage:
                      NetworkImage(widget.sohbetEdilenUser.profileUrl!),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: messageField,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        oankiMesaj.mesaj,
                        style: TextStyle(fontSize: 17.sp, color: white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(timeAndMinuteValue),
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
