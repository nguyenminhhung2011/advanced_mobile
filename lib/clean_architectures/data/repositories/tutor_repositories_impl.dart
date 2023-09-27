import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/base_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/data_state.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/tutor/tutor_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/tutors_response/tutors_response.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_detail.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_fav/tutor_fav.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/tutor_repositories.dart';
import 'package:flutter_base_clean_architecture/core/components/network/app_exception.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TutorRepositories)
class TutorRepositoriesImpl extends BaseApi implements TutorRepositories {
  final TutorApi _tutorApi;

  TutorRepositoriesImpl(this._tutorApi);

  @override
  SingleResult<TutorFav> pagFetchTutorsData(
          {required int page, required int perPge}) =>
      SingleResult.fromCallable(() async {
        await Future.delayed(const Duration(seconds: 2));
        final response = await getStateOf<TutorsResponse?>(
          request: () async => await _tutorApi.pagFetchData(page, perPge),
        );
        if (response is DataFailed) {
          return Either.left(
            AppException(message: response.dioError?.message ?? 'Error'),
          );
        }
        final tutorResponse = response.data;

        if (tutorResponse == null) {
          return Either.left(AppException(message: 'Data error'));
        }

        return Either.right(TutorFav(
          tutors: Pagination<Tutor>(
            count: tutorResponse.count,
            currentPage: page,
            rows: tutorResponse.tutors.map((e) => e.toEntity()).toList(),
          ),
          fav: response.data?.favTutors ?? [],
        ));
      });

  @override
  SingleResult<bool> addTutorToFavorite({required String userId}) =>
      SingleResult.fromCallable(
        () async {
          final response = await getStateOf(
            request: () async =>
                await _tutorApi.addTutorToFavorite(body: {"tutorId": userId}),
          );
          if (response is DataFailed) {
            return Either.left(
              AppException(message: response.dioError?.message ?? 'Error'),
            );
          }
          return const Either.right(true);
        },
      );

  @override
  SingleResult<TutorFav?> searchTutor(
          {required SearchTutorRequest searchTutorRequest}) =>
      SingleResult.fromCallable(() async {
        await Future.delayed(const Duration(seconds: 2));
        final body = {
          'page': searchTutorRequest.page,
          'perPage': searchTutorRequest.perPage,
          'search': searchTutorRequest.search,
          'filters': {
            'specialties': searchTutorRequest.topics,
            'nationality': searchTutorRequest.nationality,
          },
        };
        final response = await getStateOf(
            request: () async => await _tutorApi.searchTutor(body: body));
        if (response is DataFailed) {
          return Either.left(
            AppException(message: response.dioError?.message ?? 'Error'),
          );
        }
        final tutorResponse = response.data;
        if (tutorResponse == null) {
          return Either.left(
            AppException(message: 'Data null'),
          );
        }
        return Either.right(
          TutorFav(
            tutors: Pagination<Tutor>(
              count: tutorResponse.count,
              currentPage: searchTutorRequest.page,
              rows: tutorResponse.tutors.map((e) => e.toEntity()).toList(),
            ),
          ),
        );
      });

  @override
  SingleResult<TutorDetail?> getTutorById({required String userId}) =>
      SingleResult.fromCallable(() async {
        final response = await getStateOf(
            request: () async => _tutorApi.getTutorById(userId));
        if (response is DataFailed) {
          return Either.left(
            AppException(message: response.dioError?.message ?? 'Error'),
          );
        }
        final tutorDetail = response.data;
        if (tutorDetail == null) {
          return Either.left(
            AppException(message: 'Data null'),
          );
        }
        return Either.right(tutorDetail.toEntity());
      });

  @override
  SingleResult<List<Schedule>> getTutorSchedule(
          {required String tutorId,
          required DateTime startTime,
          required DateTime endTime}) =>
      SingleResult.fromCallable(() async {
        await Future.delayed(const Duration(seconds: 2));
        final response = await getStateOf(
          request: () async => await _tutorApi.fetchTutorSchedule(tutorId,
              startTime.millisecondsSinceEpoch, endTime.millisecondsSinceEpoch),
        );
        if (response is DataFailed) {
          return Either.left(
            AppException(message: response.dioError?.message ?? 'Error'),
          );
        }
        final listSchedule = response.data;
        if (listSchedule == null) {
          return Either.left(
            AppException(message: 'Data null'),
          );
        }
        listSchedule.schedules
            .sort((a, b) => a.startTimestamp > b.startTimestamp ? 1 : 0);
        return Either.right(
          listSchedule.schedules
              .where((e) => !e.isBooked)
              .map((e) => e.toEntity())
              .toList(),
        );
      });
}
