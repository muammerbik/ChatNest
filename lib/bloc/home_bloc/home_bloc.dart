import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/get_it/get_it.dart';
import 'package:chat_menager/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final repository = locator<Repository>();
  String? _currentUserId;

  HomeBloc()
      : super(
          HomeState(
            status: HomeStatus.init,
            allUserList: [],
            hasMore: true,
            pagePressPost: 12,
            latestUser: null,
            isLoading: false,
            searchList: [],
            searchController: TextEditingController(),
          ),
        ) {
    on<GetAllUserListWithPaginationEvent>(_getUserWithPagination);
    on<LoadMoreEvent>(_loadMore);
    on<RefreshIndicatorEvent>(_refreshIndicator);
    on<SearchListEvent>(_searchList);

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
      _currentUserId = event.currentUserId;
      debugPrint("Getting users with current user ID: $_currentUserId");

      if (!event.bringNewUser) {
        emit(state.copyWith(status: HomeStatus.loading, isLoading: true));
      }

      final newList = await repository.getUserWithPagination(
        event.latestFetchedUser,
        state.pagePressPost,
      );

      debugPrint("Fetched ${newList.length} users, filtering out current user");

      // Mevcut kullanıcıyı filtrele
      final filteredList = _currentUserId != null
          ? newList.where((user) => user.userId != _currentUserId).toList()
          : newList;

      debugPrint("Filtered list contains ${filteredList.length} users");

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
      debugPrint("Hata oluştu: $e");
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
        bringNewUser: false,
        currentUserId: _currentUserId,
      ),
    );
  }

  Future<void> _searchList(
      SearchListEvent event, Emitter<HomeState> emit) async {
    var text = state.searchController.text.trim();
    List<UserModel> newList = [];

    if (text.isEmpty) {
      newList = state.allUserList;
    } else {
      for (var userList in state.allUserList) {
        if (userList.getDisplayName().toLowerCase().contains(
              text.toLowerCase(),
            )) {
          newList.add(userList);
        }
      }
    }

    emit(
      state.copyWith(searchList: newList),
    );
  }
}
