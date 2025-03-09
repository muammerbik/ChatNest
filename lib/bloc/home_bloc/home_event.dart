part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAllUserListWithPaginationEvent extends HomeEvent {
  final UserModel? latestFetchedUser;
  final bool bringNewUser;

  const GetAllUserListWithPaginationEvent({
    required this.latestFetchedUser,
    required this.bringNewUser,
  });

  @override
  List<Object> get props =>
      [latestFetchedUser ?? UserModel(email: "", userId: ""), bringNewUser];
}

class LoadMoreEvent extends HomeEvent {
  const LoadMoreEvent();

  @override
  List<Object> get props => [];
}

class RefreshIndicatorEvent extends HomeEvent {
  const RefreshIndicatorEvent();

  @override
  List<Object> get props => [];
}
