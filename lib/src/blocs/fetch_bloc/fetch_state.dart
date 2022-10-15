part of 'fetch_bloc.dart';

abstract class FetchState extends Equatable {}

class FetchInitial extends FetchState {
  @override
  List<Object> get props => [];
}

class FetchError extends FetchState {
  @override
  List<Object> get props => [];
}

class FetchSuccess extends FetchState {
  List<UserList> userList = [];

  FetchSuccess(this.userList);

  @override
  List<Object> get props => [userList];
}
