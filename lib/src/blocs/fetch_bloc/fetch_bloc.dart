import 'package:zaigo_assesment/src/model/LawersListResponse.dart';
import 'package:zaigo_assesment/src/webservice/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_event.dart';

part 'fetch_state.dart';

class FetchBloc extends Bloc<FetchEvent, FetchState> {
  final CommonRepo? _commonRepo;

  FetchBloc(this._commonRepo) : super(FetchInitial()) {
    /* final RepositoryFetchData _repo_fetch = RepositoryFetchData();
    on<FetchEvent>((event, emit) async {
      List<User> users = await _repo_fetch.FetchUsers();
      print("${users}");
      emit(FetchSuccess(users));
    });*/

    on<FetchEvent>((event, emit) async {
      LawersListResponse? result = await _commonRepo!.getUserList();
      if (result != null && result.code! == 200) {
        emit(FetchSuccess(result.userList!));
      }
    });
  }
}
