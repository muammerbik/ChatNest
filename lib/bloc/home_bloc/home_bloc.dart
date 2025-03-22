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
  String? _currentUserId; // Mevcut kullanıcı ID'sini saklamak için

  HomeBloc()
      : super(
          HomeState(
            status: HomeStatus.init,
            allUserList: [],
            hasMore: true,
            pagePressPost: 12,
            latestUser: null,
            isLoading: false,
          ),
        ) {
    on<GetAllUserListWithPaginationEvent>(_getUserWithPagination);
    on<LoadMoreEvent>(_loadMore);
    on<RefreshIndicatorEvent>(_refreshIndicator);

    add(
      const GetAllUserListWithPaginationEvent(
        latestFetchedUser: null,
        bringNewUser: false,
      ),
    );
  }

  Future<void> _getUserWithPagination(
    GetAllUserListWithPaginationEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // Mevcut kullanıcı ID'sini sakla
      if (event.currentUserId != null) {
        _currentUserId = event.currentUserId;
      }

      if (!event.bringNewUser) {
        emit(state.copyWith(status: HomeStatus.loading, isLoading: true));
      }

      final newList = await repository.getUserWithPagination(
        event.latestFetchedUser,
        state.pagePressPost,
      );

      // Mevcut kullanıcıyı filtrele
      final filteredList =
          newList.where((user) => user.userId != _currentUserId).toList();

      final addList = filteredList
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



  Future<void> _loadMore(
    LoadMoreEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasMore && !state.isLoading) {
      add(
        GetAllUserListWithPaginationEvent(
          latestFetchedUser: state.latestUser,
          bringNewUser: true,
          currentUserId: _currentUserId,
        ),
      );
    } else {
      await Future.delayed(const Duration(seconds: 2));
    }
  }



  Future<void> _refreshIndicator(
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
      GetAllUserListWithPaginationEvent(
        latestFetchedUser: null,
        bringNewUser: true,
        currentUserId: _currentUserId,
      ),
    );
  }
}
