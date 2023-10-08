import 'package:disposebag/disposebag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/search/search_tutor_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/bloc/search_tutor_state.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/ob/constant.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/ob/naotionality_tutor.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@injectable
class SearchTutorBloc extends DisposeCallbackBaseBloc {
  ///[functions] input
  final Function0<void> fetchTopicsData;

  final Function1<Topic, void> selectedTopic;

  final Function1<String, void> openSearchResultPage;

  final Function1<NationalityTutor, void> selectedNationalityTutor;

  ///[Streams]

  final Stream<List<Topic>> topics$;

  final Stream<List<Topic>> topicSelected$;

  final Stream<bool?> loading$;

  final Stream<SearchTutorState> state$;

  final Stream<NationalityTutor> nationalityTutor;

  SearchTutorBloc._({
    required Function0<void> dispose,
    required this.selectedNationalityTutor,
    required this.openSearchResultPage,
    required this.nationalityTutor,
    required this.fetchTopicsData,
    required this.topicSelected$,
    required this.selectedTopic,
    required this.loading$,
    required this.topics$,
    required this.state$,
  }) : super(dispose);

  factory SearchTutorBloc({required SearchTutorUseCase searchTutorUseCase}) {
    final topicController =
        BehaviorSubject<List<Topic>>.seeded(List<Topic>.empty(growable: true));

    final topicSelectedController =
        BehaviorSubject<List<Topic>>.seeded(List<Topic>.empty(growable: true));

    final nationalityTutorController =
        BehaviorSubject<NationalityTutor>.seeded(constNationalityTutors.first);

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final selectedNationalityTutorController =
        PublishSubject<NationalityTutor>();

    final fetchTopicsController = PublishSubject<void>();

    final selectedTopicController = PublishSubject<Topic>();

    final openSearchResultPageController = PublishSubject<String>();

    ///🌟[Actions]

    final fetchTopics$ = fetchTopicsController
        .withLatestFrom(loadingController.stream, (_, loading) => !loading)
        .share();

    final selectedTopicState$ = selectedTopicController.stream.map((topic) {
      final currentSelectedTopics = topicSelectedController.value;
      if (currentSelectedTopics.contains(topic)) {
        topicSelectedController.add(
          currentSelectedTopics.where((element) => element != topic).toList(),
        );
      } else {
        topicSelectedController.add([...currentSelectedTopics, topic]);
      }
      return const SelectedTopicSuccess();
    }).share();

    final selectedNationalityTutorState$ =
        selectedNationalityTutorController.stream.map((nTutor) {
      nationalityTutorController.add(nTutor);
      return const SelectedNationalityTutorSuccess();
    }).share();

    final openSearchResultPageState$ = openSearchResultPageController.stream
        .map((searchText) => OpenSearchTutorResultPageSuccess(
              searchTutorRequest: SearchTutorRequest(
                perPage: 0,
                page: 10,
                search: searchText,
                topics: topicSelectedController.value
                    .map((e) => e.key?.toLowerCase().trim() ?? '')
                    .toList(),
                nationality: {
                  'isVietNamese': nationalityTutorController.value.isVietNamese
                },
              ),
            ))
        .share();

    final fetchTopicState$ = Rx.merge([
      fetchTopics$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .exhaustMap((_) {
        try {
          return searchTutorUseCase
              .getTopics()
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
                    ifLeft: (error) => FetchTopicsFailed(
                        message: error.message, error: error.code),
                    ifRight: (List<Topic> listTopic) {
                      if (listTopic.isNotEmpty) {
                        topicController.add(
                          [const Topic(name: 'All'), ...listTopic],
                        );
                      }
                      return const FetchTopicsSuccess();
                    }),
              );
        } catch (e) {
          return Stream<SearchTutorState>.error(
            FetchTopicsFailed(message: e.toString()),
          );
        }
      }),
      fetchTopics$.where((isValid) => !isValid).map(
            (_) => const InValidSearchTutor(),
          )
    ]).whereNotNull().share();

    final state$ = Rx.merge<SearchTutorState>([
      fetchTopicState$,
      selectedTopicState$,
      openSearchResultPageState$,
      selectedNationalityTutorState$,
    ]).whereNotNull().share();

    final subscriptions = <String, Stream>{
      'state': state$,
      'loadingController': loadingController,
    }.debug();

    return SearchTutorBloc._(
      dispose: () async => await DisposeBag([
        topicController,
        loadingController,
        fetchTopicsController,
        selectedTopicController,
        topicSelectedController,
        nationalityTutorController,
        openSearchResultPageController,
        selectedNationalityTutorController,
        ...subscriptions,
      ]).dispose(),
      fetchTopicsData: () => fetchTopicsController.add(null),
      topicSelected$: topicSelectedController,
      selectedTopic: (topic) => selectedTopicController.add(topic),
      selectedNationalityTutor: (tutorString) =>
          selectedNationalityTutorController.add(tutorString),
      loading$: loadingController,
      topics$: topicController,
      nationalityTutor: nationalityTutorController,
      openSearchResultPage: (searchText) =>
          openSearchResultPageController.add(searchText.trim()),
      state$: state$,
    );
  }
}
