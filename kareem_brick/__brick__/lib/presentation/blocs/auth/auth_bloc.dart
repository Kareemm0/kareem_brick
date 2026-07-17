import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/core.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc<T> extends Bloc<AuthEvent, AuthState> {
  final BaseCallableClass<T, BaseInput> _actions;
  AuthBloc(this._actions) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      await _login(event, emit);
    });
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoginLoadingState());
      _actions(event.input);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
  }
}
