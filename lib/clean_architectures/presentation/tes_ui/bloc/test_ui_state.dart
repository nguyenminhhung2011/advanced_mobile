part of 'test_ui_bloc.dart';

@freezed 
class TestUiState with _$TestUiState{
  const factory TestUiState.initial({
    required TestUiModalState data, 
  }) = _Initial;
} 