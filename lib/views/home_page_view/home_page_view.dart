import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/empty_page_view/empty_page_view.dart';
import 'package:chat_menager/views/loading_page_view/loading_page.dart';
import 'package:chat_menager/views/message_page_view/message_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_menager/bloc/home_bloc/home_bloc.dart';
import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    super.key,
  });

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final ScrollController _scrollController = ScrollController();

  void _refreshUserList() {
    final currentUser = context.read<SignUpBloc>().state.userModel;
    if (currentUser.userId.isNotEmpty) {
      debugPrint("Refreshing user list with current user ID: ${currentUser.userId}");
      context.read<HomeBloc>().add(
            GetAllUserListWithPaginationEvent(
              latestFetchedUser: null,
              bringNewUser: false,
              currentUserId: currentUser.userId,
            ),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _refreshUserList();
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
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpBloc, SignUpState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == SignUpStatus.success,
          listener: (context, state) {
            _refreshUserList();
          },
        ),
        BlocListener<SignInBloc, SignInState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == SignInStatus.success,
          listener: (context, state) {
            _refreshUserList();
          },
        ),
      ],
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return LoadingPageView();
          } else {
            return Scaffold(
              appBar: CustomAppBarView(
                appBarTitle: users,
                actionIcons: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: black,
                    ),
                  ),
                ],
              ),
              body: state.allUserList.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<HomeBloc>()
                            .add(const RefreshIndicatorEvent());
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.hasMore
                            ? state.allUserList.length + 1
                            : state.allUserList.length,
                        itemBuilder: (context, index) {
                          if (index >= state.allUserList.length) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 16.h),
                              child: Center(
                                child: Lottie.asset(loadingJson),
                              ),
                            );
                          }

                          final user = state.allUserList[index];
                          return BlocBuilder<SignUpBloc, SignUpState>(
                            builder: (context, signUpState) {
                              final currentUser = signUpState.userModel;

                              return GestureDetector(
                                onTap: () {
                                  if (currentUser.userId.isNotEmpty) {
                                    debugPrint(
                                        "Navigating with currentUser: ${currentUser.toString()}");
                                    debugPrint(
                                        "Selected user: ${user.toString()}");

                                    Navigation.push(
                                      page: MessagePageView(
                                        currentUser: currentUser,
                                        chattedUser: user,
                                      ),
                                    );
                                  } else {
                                    debugPrint(
                                        "Warning: currentUser.userId is empty!");
                                  }
                                },
                                child: Container(
                                  color: white,
                                  child: ListTile(
                                    title: TextWidgets(
                                      text: user.getDisplayName(),
                                      size: 16.sp,
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    leading: user.profileUrl != null &&
                                            user.profileUrl!.isNotEmpty
                                        ? CircleAvatar(
                                            radius: 24.r,
                                            backgroundColor: grey.withAlpha(30),
                                            backgroundImage:
                                                NetworkImage(user.profileUrl!),
                                          )
                                        : CircleAvatar(
                                            radius: 24.r,
                                            backgroundColor: grey.withAlpha(30),
                                            backgroundImage: AssetImage(
                                              userImage,
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : EmptyPageView(
                      message: homeEmptyPageText,
                    ),
            );
          }
        },
      ),
    );
  }
}
