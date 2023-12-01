import 'dart:async';

import 'package:lettutor/clean_architectures/presentation/tes_ui/bloc/test_ui_modal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'test_ui_event.dart';
part 'test_ui_state.dart';

part 'test_ui_bloc.freezed.dart';

@injectable
class TestUiBloc extends Bloc<TestUiEvent, TestUiState> {
  TestUiBloc() : super(const TestUiState.initial(data: TestUiModalState())) {
    on<_Started>(_onStarted);
  }

  FutureOr<void> _onStarted(
    _Started event,
    Emitter<TestUiState> emit,
  ) {}
}
