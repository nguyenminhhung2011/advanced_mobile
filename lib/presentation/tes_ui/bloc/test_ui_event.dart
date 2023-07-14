part of 'test_ui_bloc.dart';

@freezed 
class TestUiEvent with _$TestUiEvent{
  const factory TestUiEvent.started() = _Started;
}