part of 'home_bloc.dart';

enum HomeStatus { init, loading, success, error }

// ignore: must_be_immutable
class HomeState extends Equatable {
  final HomeStatus status;
  final List<UserModel> allUserList;
  final bool hasMore;
  final UserModel? latestUser;
  final int pagePressPost;
  final bool isLoading;
  final List<UserModel> searchList;
  TextEditingController searchController = TextEditingController();

  HomeState(
      {required this.status,
      required this.allUserList,
      required this.hasMore,
      this.latestUser,
      required this.pagePressPost,
      required this.isLoading,
      required this.searchList,
      required this.searchController});

  HomeState copyWith({
    HomeStatus? status,
    List<UserModel>? allUserList,
    bool? hasMore,
    UserModel? latestUser,
    int? pagePressPost,
    bool? isLoading,
    List<UserModel>? searchList,
    TextEditingController? searchController,
  }) {
    return HomeState(
        status: status ?? this.status,
        allUserList: allUserList ?? this.allUserList,
        hasMore: hasMore ?? this.hasMore,
        latestUser: latestUser ?? this.latestUser,
        pagePressPost: pagePressPost ?? this.pagePressPost,
        isLoading: isLoading ?? this.isLoading,
        searchList: searchList ?? this.searchList,
        searchController: searchController ?? this.searchController);
  }

  @override
  List<Object?> get props => [
        status,
        allUserList,
        hasMore,
        latestUser,
        pagePressPost,
        isLoading,
        searchList,
        searchController
      ];
}
