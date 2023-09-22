import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class SearchTutorState {}

class FetchTopicsSuccess implements SearchTutorState {
  const FetchTopicsSuccess();
}

class FetchTopicsFailed implements SearchTutorState {
  final String? message;
  final Object? error;

  const FetchTopicsFailed({this.error, this.message});

  @override
  String toString() =>
      "[Fetch topic errors] => message ${message ?? ''}, error ${error ?? ''} ";
}

class InValidSearchTutor implements SearchTutorState {
  const InValidSearchTutor();
}

class SelectedTopicSuccess implements SearchTutorState {
  const SelectedTopicSuccess();
}

class SelectedNationalityTutorSuccess implements SearchTutorState {
  const SelectedNationalityTutorSuccess();
}

class OpenSearchTutorResultPageSuccess implements SearchTutorState {
  final SearchTutorRequest searchTutorRequest;
  OpenSearchTutorResultPageSuccess({required this.searchTutorRequest});
}
