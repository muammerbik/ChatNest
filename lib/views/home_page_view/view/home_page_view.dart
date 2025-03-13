import 'package:chat_menager/views/message_page_view/view/message_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_menager/bloc/home_bloc/home_bloc.dart';
import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<HomeBloc>().add(const LoadMoreEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarView(
        appBarTitle: 'Kullanıcılar',
        centerTitle: false,
        textColor: Colors.black,
        actionIcons: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading && state.allUserList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == HomeStatus.error) {
            return const Center(child: Text('Bir hata oluştu'));
          } else if (state.allUserList.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(const RefreshIndicatorEvent());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 150.h,
                  child: Center(
                    child: Text(
                      'Kayıtlı kullanıcı bulunamadı',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(const RefreshIndicatorEvent());
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.hasMore
                  ? state.allUserList.length + 1
                  : state.allUserList.length,
              itemBuilder: (context, index) {
                if (index >= state.allUserList.length) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final user = state.allUserList[index];
                return BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, signUpState) {
                    if (signUpState.status == SignUpStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final currentUser = signUpState.userModel;
                    if (user.userId == currentUser.userId) {
                      return Container();
                    }

                    return GestureDetector(
                      onTap: () {
                        if (currentUser.userId.isNotEmpty) {
                          debugPrint(
                              "Navigating with currentUser: ${currentUser.toString()}");
                          debugPrint("Selected user: ${user.toString()}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagePageView(
                                currentUser: currentUser,
                                sohbetEdilenUser: user,
                              ),
                            ),
                          );
                        } else {
                          debugPrint("Warning: currentUser.userId is empty!");
                        }
                      },
                      child: Card(
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: TextWidgets(
                              text: user.userName ?? '',
                              size: 16.sp,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w500,
                            ),
                            subtitle: TextWidgets(
                              text: user.email,
                              size: 14.sp,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.normal,
                            ),
                            leading: user.profileUrl != null &&
                                    user.profileUrl!.isNotEmpty
                                ? CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey.withAlpha(30),
                                    backgroundImage:
                                        NetworkImage(user.profileUrl!),
                                  )
                                : CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey.withAlpha(30),
                                    backgroundImage: AssetImage(
                                      "assets/icons/user_avatar.png",
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
