part of 'home_bloc.dart';

enum HomeStatus { init, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<UserModel> allUserList;
  final bool hasMore;
  final UserModel? latestUser;
  final int pagePressPost;
  final bool isLoading;

  const HomeState(
      {required this.status,
      required this.allUserList,
      required this.hasMore,
      this.latestUser,
      required this.pagePressPost,
      required this.isLoading});

  HomeState copyWith({
    HomeStatus? status,
    List<UserModel>? allUserList,
    bool? hasMore,
    UserModel? latestUser,
    int? pagePressPost,
    bool? isLoading,
  }) {
    return HomeState(
      status: status ?? this.status,
      allUserList: allUserList ?? this.allUserList,
      hasMore: hasMore ?? this.hasMore,
      latestUser: latestUser ?? this.latestUser,
      pagePressPost: pagePressPost ?? this.pagePressPost,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [status, allUserList, hasMore, latestUser, pagePressPost, isLoading];
}
