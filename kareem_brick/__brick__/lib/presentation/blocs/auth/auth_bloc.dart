import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _repo;
  final BaseLocalStorage _localStorage;

  AuthBloc({
    required AuthRepo repo,
    required BaseLocalStorage localStorage,
  })  : _localStorage = localStorage,
        _repo = repo,
        super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      final result = await _repo.login(event.inputs);

      final resultingState = await result
          .fold((failure) async => LoginFailureState(msg: failure.msg),
              (response) async {
        try {
          await _localStorage.setString(LocalKeys.accessToken, response.token);
        } catch (e) {
          return LoginFailureState(msg: "Something went wrong!");
        }
        return LoginSuccessState();
      });
      emit(resultingState);
    });
  }
}
