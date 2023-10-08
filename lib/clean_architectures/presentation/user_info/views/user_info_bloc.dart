import 'dart:typed_data';

import 'package:disposebag/disposebag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/user_info_usecase/user_info_usecse.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/user_info/views/user_info_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_base_clean_architecture/core/services/image_pic_service.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class UpdateProfileRequest {
  final String name;
  final String country;
  final DateTime birthDay;
  final String level;
  final String studySchedule;
  final List<String>? learnTopic;
  final List<String>? testPreparations;

  UpdateProfileRequest({
    required this.name,
    required this.country,
    required this.birthDay,
    required this.level,
    required this.studySchedule,
    this.learnTopic,
    this.testPreparations,
  });

  Map<String, dynamic> get toMap => {
        'name': name,
        'country': country.toUpperCase(),
        'birthday': DateFormat('yyyy-MM-dd').format(birthDay),
        'level': level,
        'learnTopics': learnTopic ?? <String>[],
        'testPreparations': testPreparations ?? <String>[],
        'studySchedule': studySchedule,
      };
}

@injectable
class UserInfoBloc extends DisposeCallbackBaseBloc {
  ///[User info]
  final Function0<void> getUserInfo;

  final Function0<void> changeAvatar;

  final Function0<void> fetchTopicsData;

  final Function0<void> popeScreen;

  final Function1<Topic, void> selectedTopic;

  final Function1<UpdateProfileRequest, void> updateProfile;

  ///[Stream]

  final Stream<User?> user$;

  final Stream<Uint8List?> memoryImage;

  final Stream<List<Topic>> topics$;

  final Stream<List<Topic>> topicSelected$;

  final Stream<UserInfoState> state$;

  final Stream<bool?> loading$;

  UserInfoBloc._({
    required Function0<void> dispose,
    required this.popeScreen,
    required this.getUserInfo,
    required this.updateProfile,
    required this.fetchTopicsData,
    required this.selectedTopic,
    required this.topics$,
    required this.topicSelected$,
    required this.changeAvatar,
    required this.memoryImage,
    required this.user$,
    required this.state$,
    required this.loading$,
  }) : super(dispose);

  factory UserInfoBloc(
      {required UserInfoUseCase userInfoUseCase,
      required ImagePicService imagePicService}) {
    final topicController =
        BehaviorSubject<List<Topic>>.seeded(List<Topic>.empty(growable: true));

    final topicSelectedController =
        BehaviorSubject<List<Topic>>.seeded(List<Topic>.empty(growable: true));

    final loadingController = BehaviorSubject<bool?>.seeded(false);

    final userController = BehaviorSubject<User?>.seeded(null);

    final updateProfileRequestController =
        BehaviorSubject<UpdateProfileRequest?>.seeded(null);

    final memoryImageController = BehaviorSubject<Uint8List?>.seeded(null);

    final getUserInfoController = PublishSubject<void>();

    final changeAvatarController = PublishSubject<void>();

    final popScreenController = PublishSubject<void>();

    final fetchTopicsController = PublishSubject<void>();

    final updateProfileController = PublishSubject<void>();

    final selectedTopicController = PublishSubject<Topic>();

    final getUserInfo$ = getUserInfoController.stream
        .withLatestFrom(
            loadingController.stream, (_, loading) => !(loading ?? false))
        .share();

    final changeAvatarState$ = changeAvatarController
        .debug(identifier: 'ChangeAvatar [1]', log: debugPrint)
        .switchMap(
          (_) => Rx.fromCallable(
                  () => imagePicService.pickImage(ImageSource.gallery))
              .debug(identifier: 'Choose image', log: debugPrint),
        )
        .debug(identifier: 'Change avatar [2]', log: debugPrint)
        .map((file) => file)
        .whereNotNull()
        .distinct()
        .map((value) {
      memoryImageController.add(value);
      return const ChangeAvatarSuccess();
    });

    ///[Handle topics]
    final selectedTopicState$ = selectedTopicController.stream.map((topic) {
      final currentSelectedTopics = topicSelectedController.value;
      if (currentSelectedTopics
              .indexWhere((element) => element.key == topic.key) !=
          -1) {
        topicSelectedController.add(
          currentSelectedTopics
              .where((element) => element.key != topic.key)
              .toList(),
        );
      } else {
        topicSelectedController.add([...currentSelectedTopics, topic]);
      }
      return const SelectedTopicUserInfoSuccess();
    }).share();

    final fetchTopicState$ =
        fetchTopicsController.debug(log: debugPrint).exhaustMap((_) {
      try {
        return userInfoUseCase.getTopics().map(
              (data) => data.fold(
                  ifLeft: (error) => FetchTopicsUserInfoFailed(
                      message: error.message, error: error.code),
                  ifRight: (listTopic) {
                    if (listTopic.isNotEmpty) {
                      topicController.add(listTopic);
                    }
                    return const FetchTopicsUserInfoSuccess();
                  }),
            );
      } catch (e) {
        return Stream<UserInfoState>.error(
          FetchTopicsUserInfoFailed(message: e.toString()),
        );
      }
    });

    ///[Handle update profile]
    ///
    final isValid$ = Rx.combineLatest2(
      loadingController.stream,
      updateProfileRequestController.stream,
      (loading, value) {
        if (value == null) {
          return false;
        }
        return (value.name.isNotEmpty &&
                value.country.isNotEmpty &&
                value.level.isNotEmpty) &&
            !(loading ?? false);
      },
    ).shareValueSeeded(false);

    final updateProfile$ = updateProfileController.stream
        .withLatestFrom(isValid$, (_, isValid) => isValid)
        .share();

    final updateProfileState$ = Rx.merge<UserInfoState>([
      updateProfile$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .withLatestFrom(updateProfileRequestController.stream, (_, s) => s!)
          .exhaustMap(
            (request) => userInfoUseCase
                .updateUserInf(updateProfileRequest: request)
                .doOn(
                  listen: () => loadingController.add(true),
                  cancel: () => loadingController.add(false),
                )
                .map((data) => data.fold(
                      ifLeft: (error) => UpdateProfileUserInfoFailed(
                          message: error.message, error: error.code),
                      ifRight: (cData) {
                        userController.add(cData);
                        return const UpdateProfileUserInfoSuccess();
                      },
                    )),
          ),
      updateProfile$
          .where((isValid) => !isValid)
          .map((_) => const UpdateProfileUserInfoFailed(message: 'Invalid'))
    ]).whereNotNull().share();

    final popScreenState$ = popScreenController.stream
        .withLatestFrom(userController.stream, (_, user) => user)
        .map((event) => PopScreenSuccess(event!));

    final state$ = Rx.merge<UserInfoState>([
      popScreenState$,
      updateProfileState$,
      fetchTopicState$,
      changeAvatarState$,
      selectedTopicState$,
      getUserInfo$.where((isValid) => isValid).exhaustMap((event) {
        try {
          return userInfoUseCase
              .getUserInfo()
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map((data) => data.fold(
                  ifLeft: (error) => GetUserInfoFailed(
                      message: error.message, error: error.code),
                  ifRight: (cData) {
                    userController.add(cData);

                    topicSelectedController.add(<Topic>[
                      ...cData.learnTopics,
                      ...cData.testPreparations
                    ]);
                    return GetUserInfoSuccess(cData);
                  }));
        } catch (e) {
          return Stream.error(GetUserInfoFailed(message: e.toString()));
        }
      }),
      getUserInfo$.where((isValid) => !isValid).map(
            (_) => const GetUserInfoFailed(message: 'Invalid format'),
          )
    ]).whereNotNull().share();

    final subscriptions = <String, Stream>{
      'state': state$,
      'loadingController': loadingController,
      'isValid': isValid$,
    }.debug();

    return UserInfoBloc._(
      memoryImage: memoryImageController,
      changeAvatar: () => changeAvatarController.add(null),
      dispose: () async => await DisposeBag([
        loadingController,
        userController,
        getUserInfoController,
        changeAvatarController,
        memoryImageController,
        topicController,
        fetchTopicsController,
        selectedTopicController,
        topicSelectedController,
        updateProfileController,
        updateProfileRequestController,
        popScreenController,
        ...subscriptions,
      ]).dispose(),
      updateProfile: (request) {
        final currentTopicSelected = topicSelectedController.value;
        updateProfileRequestController.add(UpdateProfileRequest(
          name: request.name,
          country: request.country,
          birthDay: request.birthDay,
          level: request.level,
          studySchedule: request.studySchedule,
          learnTopic: currentTopicSelected
              .where((element) => element.isTopics ?? false)
              .map((e) => e.id.toString())
              .toList(),
          testPreparations: currentTopicSelected
              .where((element) => !(element.isTopics ?? false))
              .map((e) => e.id.toString())
              .toList(),
        ));
        updateProfileController.add(null);
      },
      popeScreen: () => popScreenController.add(null),
      getUserInfo: () => getUserInfoController.add(null),
      user$: userController,
      state$: state$,
      loading$: loadingController,
      fetchTopicsData: () => fetchTopicsController.add(null),
      topicSelected$: topicSelectedController,
      selectedTopic: (topic) => selectedTopicController.add(topic),
      topics$: topicController,
    );
  }
}
