import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:chat_menager/repository/repository.dart';
import 'package:equatable/equatable.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final repository = locator<Repository>();

  HomeBloc()
      : super(
          HomeState(
            status: HomeStatus.init,
            allUserList: [],
            hasMore: true,
            pagePressPost: 10,
            latestUser: null,
            isLoading: false,
          ),
        ) {
    on<GetAllUserListWithPaginationEvent>(getUserWithPagination);
    on<LoadMoreEvent>(loadMore);
    on<RefreshIndicatorEvent>(refreshIndicator);

    add(const GetAllUserListWithPaginationEvent(
      latestFetchedUser: null,
      bringNewUser: false,
    ));
  }

  Future<void> getUserWithPagination(
    GetAllUserListWithPaginationEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (!event.bringNewUser) {
        emit(state.copyWith(status: HomeStatus.loading, isLoading: true));
      }

      final newList = await repository.getUserWithPagination(
        event.latestFetchedUser,
        state.pagePressPost,
      );

      final addList = newList
          .where(
            (newUser) => !state.allUserList
                .any((currentUser) => currentUser.userId == newUser.userId),
          )
          .toList();

      final newAllUserList = List<UserModel>.from(state.allUserList)
        ..addAll(addList);

      final hasMore = addList.length == state.pagePressPost;

      emit(
        state.copyWith(
          status: HomeStatus.success,
          allUserList: newAllUserList,
          hasMore: hasMore,
          latestUser: newAllUserList.isNotEmpty ? newAllUserList.last : null,
          isLoading: false,
        ),
      );
    } catch (e) {
      print("Hata oluştu: $e");
      emit(state.copyWith(status: HomeStatus.error, isLoading: false));
    }
  }

  Future<void> loadMore(
    LoadMoreEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasMore && !state.isLoading) {
      add(
        GetAllUserListWithPaginationEvent(
          latestFetchedUser: state.latestUser,
          bringNewUser: true,
        ),
      );
    } else {
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  Future<void> refreshIndicator(
    RefreshIndicatorEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HomeStatus.init,
        allUserList: [],
        hasMore: true,
        latestUser: null,
        isLoading: false,
      ),
    );

    add(
      const GetAllUserListWithPaginationEvent(
        latestFetchedUser: null,
        bringNewUser: true,
      ),
    );
  }
}
