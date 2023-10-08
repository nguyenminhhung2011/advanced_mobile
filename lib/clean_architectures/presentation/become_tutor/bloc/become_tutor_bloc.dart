import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:disposebag/disposebag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/become_tutor/become_tutor_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/become_tutor/bloc/become_tutor_state.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_base_clean_architecture/core/services/image_pic_service.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class BecomeTutorRequest {
  final String name;
  final String country;
  final DateTime birthDay;
  final String interest;
  final String education;
  final String experience;
  final String profession;
  final String languages;
  final String bio;
  final String targetStudent;
  final List<Topic> specialties;
  final String avatar;
  final int price;
  BecomeTutorRequest(
      {required this.name,
      required this.country,
      required this.birthDay,
      required this.interest,
      required this.education,
      required this.experience,
      required this.profession,
      required this.languages,
      required this.bio,
      required this.targetStudent,
      required this.specialties,
      required this.avatar,
      required this.price});

  Future<Map<String, dynamic>> toMap() async => {
        "avatar": await MultipartFile.fromFile(
          avatar,
          filename: avatar.split('/').last,
          contentType: MediaType("image", "jpeg"),
        ),
        "name": name,
        "country": country,
        "birthday": DateFormat('yyyy-MM-dd').format(birthDay),
        "interests": interest,
        "education": education,
        "experience": experience,
        "profession": profession,
        "languages": languages,
        "bio": bio,
        "targetStudent": targetStudent,
        "specialties": specialties.map((e) => e.key).join(","),
        "price": price,
      };
}

@injectable
class BecomeTutorBloc extends DisposeCallbackBaseBloc {
  final Function1<int, void> changeStep;

  final Function0<void> selectedImage;

  final Function1<Topic, void> selectedTopic;

  final Function0<void> fetchTopicsData;

  final Function0<void> changeAvatar;

  final Function1<CountryCode, void> changeCountryCode;

  final Function1<DateTime, void> changeDateBorn;

  final Function1<String, void> changeTypeStudent;

  final Function1<Map<String, String>, void> registeringTutor;

  final Function1<String, void> getName;

  ///-----------------------------------------------

  final Stream<int> step$;

  final Stream<DateTime> dateBorn$;

  final Stream<CountryCode?> countryCode$;

  final Stream<List<Topic>> topics$;

  final Stream<List<Topic>> topicSelected$;

  final Stream<BothImageData?> bothImageData$;

  final Stream<String?> typeStudent$;

  final Stream<BecomeTutorState> state$;

  final Stream<bool> loading$;

  BecomeTutorBloc._({
    required Function0<void> dispose,
    required this.selectedImage,
    required this.changeAvatar,
    required this.fetchTopicsData,
    required this.changeStep,
    required this.selectedTopic,
    required this.changeCountryCode,
    required this.changeTypeStudent,
    required this.changeDateBorn,
    required this.getName,
    required this.registeringTutor,
    //-------------------------
    required this.countryCode$,
    required this.topicSelected$,
    required this.state$,
    required this.topics$,
    required this.dateBorn$,
    required this.step$,
    required this.bothImageData$,
    required this.typeStudent$,
    required this.loading$,
  }) : super(dispose);

  factory BecomeTutorBloc({
    required BecomeTutorUseCase becomeTutorUseCase,
    required ImagePicService imagePicService,
  }) {
    final stepController = BehaviorSubject<int>.seeded(0);

    final bothImageController = BehaviorSubject<BothImageData?>.seeded(null);

    final dateBornController = BehaviorSubject<DateTime>.seeded(DateTime.now());

    final topicController =
        BehaviorSubject<List<Topic>>.seeded(List<Topic>.empty(growable: true));

    final topicSelectedController =
        BehaviorSubject<List<Topic>>.seeded(List<Topic>.empty(growable: true));

    final countryCodeController =
        BehaviorSubject<CountryCode?>.seeded(CountryCode(code: "VN"));

    final typeStudentController =
        BehaviorSubject<String?>.seeded(Constant.userLevels.entries.first.key);

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final interestController = BehaviorSubject<String>.seeded("");

    final educationController = BehaviorSubject<String>.seeded("");

    final experienceController = BehaviorSubject<String>.seeded("");

    final professionController = BehaviorSubject<String>.seeded("");

    final bioController = BehaviorSubject<String>.seeded("");

    final languageController = BehaviorSubject<String>.seeded("");

    final nameController = BehaviorSubject<String>.seeded("");

    ///----------------------------------------------------------------

    final changeAvatarController = PublishSubject<void>();

    final fetchTopicsController = PublishSubject<void>();

    final registeringController = PublishSubject<void>();

    final selectedTopicController = PublishSubject<Topic>();

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
      return const SelectedTopicBecomeTutorSuccess();
    }).share();

    final fetchTopicState$ =
        fetchTopicsController.debug(log: debugPrint).exhaustMap((_) {
      try {
        return becomeTutorUseCase.getTopics().map(
              (data) => data.fold(
                  ifLeft: (error) => FetchTopicsUserInfoBecomeTutorFailed(
                      message: error.message, error: error.code),
                  ifRight: (listTopic) {
                    if (listTopic.isNotEmpty) {
                      topicController.add(listTopic);
                    }
                    return const FetchTopicsUserInfoBecomeTutorFailed();
                  }),
            );
      } catch (e) {
        return Stream<BecomeTutorState>.error(
          FetchTopicsUserInfoBecomeTutorFailed(message: e.toString()),
        );
      }
    });

    ///[Avatar handle]
    ///
    final changeAvatarState$ = changeAvatarController
        .debug(identifier: 'ChangeAvatar [1]', log: debugPrint)
        .switchMap(
          (_) => Rx.fromCallable(
                  () => imagePicService.selectedImage(ImageSource.gallery))
              .debug(identifier: 'Choose image', log: debugPrint),
        )
        .debug(identifier: 'Change avatar [2]', log: debugPrint)
        .map((file) => file)
        .whereNotNull()
        .distinct()
        .map((value) {
      bothImageController.add(value);
      return const ChangeAvatarSuccess();
    });

    ///[Handle registering]

    final isValid$ = Rx.combineLatest7(
      interestController.stream.map((e) => e.isNotEmpty),
      educationController.stream.map((e) => e.isNotEmpty),
      experienceController.stream.map((e) => e.isNotEmpty),
      professionController.stream.map((e) => e.isNotEmpty),
      bioController.stream.map((e) => e.isNotEmpty),
      languageController.stream.map((e) => e.isNotEmpty),
      loadingController.stream,
      (a, b, c, d, e, f, g) => (a && b && c && d && e && f) && !g,
    ).shareValueSeeded(false);

    final request$ = Rx.combineLatest(
        [
          interestController.stream, //0
          educationController.stream, //1
          experienceController.stream, //2
          professionController.stream, //3
          bioController.stream, //4
          languageController.stream, //5
          countryCodeController.stream, //6
          topicSelectedController.stream, //7
          dateBornController.stream, //8
          typeStudentController.stream, //9
          bothImageController.stream, //10
          nameController.stream, //11
        ],
        (values) => BecomeTutorRequest(
              name: values[11].toString(),
              country: (values[6] as CountryCode).code ?? "VN",
              birthDay: values[8] as DateTime,
              interest: values[0].toString(),
              education: values[1].toString(),
              experience: values[2].toString(),
              profession: values[3].toString(),
              languages: values[5].toString(),
              bio: values[4].toString(),
              targetStudent: values[9].toString(),
              specialties: values[7] as List<Topic>,
              avatar: values[10] == null
                  ? ""
                  : (values[10] as BothImageData).path ?? "",
              price: 50000,
            ));

    final submit$ = registeringController.stream
        .withLatestFrom(isValid$, (_, isValid) => isValid)
        .share();

    final registeringState$ = Rx.merge<BecomeTutorState>([
      submit$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .withLatestFrom(request$, (_, request) => request)
          .exhaustMap((request) {
        try {
          return becomeTutorUseCase
              .registeringTutor(becomeTutorRequest: request)
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
                  ifLeft: (error) => const RegisteringTutorFailed(
                      message: "User has already been a tutor"),
                  ifRight: (_) => const RegisteringTutorSuccess(),
                ),
              );
        } catch (e) {
          return Stream.error(const RegisteringTutorFailed(
              message: "User has already been a tutor"));
        }
      }),
      submit$
          .where((isValid) => !isValid)
          .map((_) => const RegisteringTutorFailed(message: "Invalid format"))
    ]).whereNotNull().share();

    final state$ = Rx.merge<BecomeTutorState>([
      selectedTopicState$,
      fetchTopicState$,
      changeAvatarState$,
      registeringState$
    ]).whereNotNull().share();

    final subscriptions = <String, Stream>{
      'state': state$,
      'loadingController': loadingController,
      'isValid': isValid$,
    }.debug();

    return BecomeTutorBloc._(
      dispose: () async => await DisposeBag([
        stepController,
        bothImageController,
        dateBornController,
        topicController,
        topicSelectedController,
        countryCodeController,
        typeStudentController,
        fetchTopicsController,
        selectedTopicController,
        changeAvatarController,
        loadingController,
        interestController,
        educationController,
        experienceController,
        professionController,
        bioController,
        languageController,
        registeringController,
        nameController,
        ...subscriptions,
      ]).dispose(),
      state$: state$,
      loading$: loadingController,
      countryCode$: countryCodeController,
      typeStudent$: typeStudentController,
      step$: stepController,
      changeAvatar: () => changeAvatarController.add(null),
      bothImageData$: bothImageController,
      changeTypeStudent: (type) => typeStudentController.add(type),
      changeStep: (index) => stepController.add(index),
      dateBorn$: dateBornController,
      selectedImage: () {},
      fetchTopicsData: () => fetchTopicsController.add(null),
      selectedTopic: (value) => selectedTopicController.add(value),
      topicSelected$: topicSelectedController,
      topics$: topicController,
      changeCountryCode: (countryCode) =>
          countryCodeController.add(countryCode),
      changeDateBorn: (dateBorn) => dateBornController.add(dateBorn),
      getName: (name) => nameController.add(name),
      registeringTutor: (textData) {
        interestController.add(textData['interest']?.toString() ?? '');
        educationController.add(textData['education']?.toString() ?? '');
        experienceController.add(textData['experience']?.toString() ?? '');
        professionController.add(textData['profession']?.toString() ?? '');
        bioController.add(textData['bio']?.toString() ?? '');
        languageController.add(textData['language']?.toString() ?? '');

        registeringController.add(null);
      },
    );
  }
}
