import 'package:collection/collection.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/become_tutor/bloc/become_tutor_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/become_tutor/bloc/become_tutor_state.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/bloc_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/log_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/layout/setting_layout/controller/setting_bloc.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/dropdown_button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class BecomeTutorView extends StatefulWidget {
  const BecomeTutorView({super.key});

  @override
  State<BecomeTutorView> createState() => _BecomeTutorViewState();
}

class _BecomeTutorViewState extends State<BecomeTutorView> {
  BecomeTutorBloc get _bloc => BlocProvider.of<BecomeTutorBloc>(context);

  SettingBloc get _settingBloc => context.readSettingBloc;

  User? get _currentUser => _settingBloc.data.currentUser;

  Color get _primaryColor => Theme.of(context).primaryColor;

  TextStyle get _hintColorText =>
      context.titleSmall.copyWith(color: Theme.of(context).hintColor);

  TextStyle get _smallText => context.titleSmall.copyWith(fontSize: 12.0);

  Object? listen;

  final _interestsController = TextEditingController();

  final _eductionController = TextEditingController();

  final _experienceController = TextEditingController();

  final _professionController = TextEditingController();

  final _bioController = TextEditingController();

  final _languageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    listen ??= _bloc.state$.flatMap(handleState).collect();
    _bloc.fetchTopicsData();
    _bloc.getName(_currentUser?.name ?? 'Minhunsocute');
  }

  void _onSelectedTime() async {
    final time = await context.pickDate(DatePickerMode.day);
    if (time != null) {
      _bloc.changeDateBorn(time);
    }
  }

  @override
  void dispose() {
    _bioController.dispose();
    _interestsController.dispose();
    _eductionController.dispose();
    _experienceController.dispose();
    _professionController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  Stream handleState(state) async* {
    if (state is RegisteringTutorFailed) {
      context.showSnackBar("🐛 ${state.toString()}");
      return;
    }
    if (state is RegisteringTutorSuccess) {
      context.showSnackBar("🌟[Registering tutor] success");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.loading$,
      builder: (ctx, sS) {
        final loading = sS.data ?? false;
        return Stack(
          children: [
            _body(context),
            if (loading)
              Container(
                color: Colors.black45,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: _loading(),
              )
          ],
        );
      },
    );
  }

  Scaffold _body(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ButtonCustom(
          height: 45.0,
          onPress: () => _bloc.registeringTutor({
            'interest': _interestsController.text,
            'education': _eductionController.text,
            'experience': _experienceController.text,
            'profession': _professionController.text,
            'bio': _bioController.text,
            'language': _languageController.text,
          }),
          child: Text(
            S.of(context).registering,
            style: context.titleMedium
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          S.of(context).tutorRegister,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: _bloc.step$,
        builder: (ctx, sS) {
          final currentIndex = sS.data ?? 0;
          return Stepper(
            currentStep: currentIndex,
            onStepContinue: () {
              if (currentIndex < 3) {
                _bloc.changeStep(currentIndex + 1);
              }
            },
            onStepCancel: () {},
            onStepTapped: (index) {
              _bloc.changeStep(index);
            },
            steps: <Step>[
              Step(
                title: Text(S.of(context).introduction,
                    style: context.titleMedium),
                content: _renderIntroduction(),
              ),
              Step(
                title: Text('CV', style: context.titleMedium),
                content: _renderCV(),
              ),
              Step(
                title: Text(S.of(context).language, style: context.titleMedium),
                content: _languageRender(),
              ),
              Step(
                title: Text(S.of(context).whoITech, style: context.titleMedium),
                content: _renderTypeStudent(),
              )
            ],
          );
        },
      ),
    );
  }

  Column _renderTypeStudent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).iAmABestAtTeaching,
          style: context.titleSmall.copyWith(
            color: Theme.of(context).hintColor,
          ),
        ),
        const SizedBox(height: 10.0),
        const SizedBox(height: 10.0),
        StreamBuilder(
          stream: _bloc.typeStudent$,
          builder: (ctx, sS) {
            final data = sS.data ?? Constant.userLevels.entries.first.key;
            return SizedBox(
              width: double.infinity,
              child: DropdownButtonCustom<String?>(
                borderWidth: 1.5,
                radius: 10.0,
                items: Constant.userLevels.entries
                    .mapIndexed(
                      (index, element) => DropdownMenuItem(
                        value: element.key,
                        child: Text(element.value),
                      ),
                    )
                    .toList(),
                value: data.toUpperCase(),
                onChange: (value) {
                  if (value != null) {
                    _bloc.changeTypeStudent(value);
                  }
                },
              ),
            );
          },
        ),
        const SizedBox(height: 20.0),
        Text(
          S.of(context).mySpecialtiesAre,
          style: context.titleSmall.copyWith(
            color: Theme.of(context).hintColor,
          ),
        ),
        StreamBuilder<List<Topic>>(
          stream: _bloc.topics$,
          builder: (ctx2, sS2) {
            final topics = sS2.data ?? <Topic>[];
            return StreamBuilder<List<Topic>>(
              stream: _bloc.topicSelected$,
              builder: (ctx3, sS3) {
                final topicSelected = sS3.data ?? <Topic>[];
                return _topicsField(
                  topics: topics,
                  topicsSelected: topicSelected,
                );
              },
            );
          },
        )
      ],
    );
  }

  Widget _topicsField(
      {required List<Topic> topics, required List<Topic> topicsSelected}) {
    return Wrap(
      spacing: 6.0,
      runSpacing: -8,
      alignment: WrapAlignment.start,
      verticalDirection: VerticalDirection.up,
      children: [
        ...topics.map((e) {
          final isSelected =
              topicsSelected.indexWhere((element) => element.key == e.key) !=
                  -1;
          return ChoiceChip(
            label: Text(
              e.name ?? '',
              style: context.titleSmall.copyWith(
                fontSize: 14,
                color: isSelected ? _primaryColor : null,
                fontWeight: FontWeight.w400,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            avatar: isSelected
                ? Icon(Icons.check, color: _primaryColor, size: 15.0)
                : null,
            selected: isSelected,
            onSelected: (_) => _bloc.selectedTopic(e),
            backgroundColor: Theme.of(context).dividerColor.withOpacity(0.07),
            selectedColor: _primaryColor.withOpacity(0.1),
          );
        })
      ],
    );
  }

  Column _languageRender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dividerText(text: S.of(context).language),
        _informationTextField(
          controller: _languageController,
          labelText: S.of(context).languages,
          hintText: "lang 1, lang 2, ....",
        ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Column _renderCV() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dividerText(text: 'CV'),
        Text(
          S.of(context).studentsWillViewThisInformation,
          style: _hintColorText,
        ),
        const SizedBox(),
        _informationTextField(
          controller: _interestsController,
          labelText: S.of(context).interests,
          hintText: S.of(context).EnterYourInterests,
        ),
        const SizedBox(),
        _informationTextField(
          controller: _eductionController,
          labelText: S.of(context).education,
          hintText: S.of(context).enterEducation,
        ),
        const SizedBox(),
        _informationTextField(
          controller: _experienceController,
          labelText: S.of(context).experiences,
          hintText: S.of(context).EnterYourExperiences,
          lines: 1,
        ),
        const SizedBox(),
        _informationTextField(
          controller: _professionController,
          labelText: S.of(context).professions,
          hintText: S.of(context).EnterYourProfessions,
          lines: 2,
        ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Column _renderIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).yourTutorProfile,
          style: _hintColorText,
        ),
        _dividerText(text: S.of(context).basicInfo),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _bloc.changeAvatar(),
              child: _renderSelectedAvatar(),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _countryCodeField(),
                  _dateBornField(),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10.0),
        _informationTextField(
          controller: _bioController,
          labelText: S.of(context).bio,
          hintText: S.of(context).enterYourBio,
        ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Widget _dateBornField() {
    return StreamBuilder(
      stream: _bloc.dateBorn$,
      builder: (ctx, sS) {
        final data = sS.data ?? DateTime.now();
        return Row(
          children: [
            Expanded(
                child: Text(getYmdFormat(data), style: context.titleSmall)),
            InkWell(
                // padding: const EdgeInsets.all(0.0),
                onTap: _onSelectedTime,
                child: Icon(Icons.calendar_month_rounded, color: _primaryColor))
          ],
        );
      },
    );
  }

  Row _countryCodeField() {
    return Row(
      children: [
        Text('I\' from ', style: context.titleSmall),
        StreamBuilder(
            stream: _bloc.countryCode$,
            builder: (ctx, sS) {
              final data = sS.data;
              return Expanded(
                child: CountryCodePicker(
                  padding: const EdgeInsets.all(0),
                  initialSelection: data?.code ?? "VN",
                  showCountryOnly: false,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  dialogBackgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  showFlagMain: true,
                  showFlag: true,
                  hideSearch: false,
                  showFlagDialog: true,
                  onChanged: _bloc.changeCountryCode,
                ),
              );
            })
      ],
    );
  }

  Widget _renderSelectedAvatar() => StreamBuilder(
      stream: _bloc.bothImageData$,
      builder: (ctx, sS) {
        final data = sS.data;
        if (data?.image.isNotNull ?? false) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.memory(
              data!.image!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          );
        }
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: _primaryColor),
            borderRadius: BorderRadius.circular(5.0),
            color: Theme.of(context).cardColor,
          ),
          alignment: Alignment.center,
          child: Text(
            S.of(context).tapToSelectedAvatar,
            style: context.titleSmall.copyWith(fontSize: 11.0),
            textAlign: TextAlign.center,
          ),
        );
      });

  TextFormField _informationTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    int lines = 3,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: lines,
      style: _smallText,
      decoration: InputDecoration(
        labelStyle: TextStyle(decorationColor: _primaryColor),
        labelText: labelText,
        hintText: hintText,
        hintStyle: _smallText.copyWith(
          color: Theme.of(context).hintColor,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Theme.of(context).dividerColor, width: 1.5),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _primaryColor, width: 1.5),
          gapPadding: 10,
        ),
      ),
    );
  }

  Row _dividerText({required String text}) {
    return Row(
      children: const [Divider(), Divider()]
          .expandIndexed((index, e) => [
                Expanded(child: e),
                if (index == 0)
                  Text(
                    text,
                    style: context.titleSmall
                        .copyWith(fontWeight: FontWeight.bold),
                  )
              ])
          .toList(),
    );
  }

  Center _loading() {
    return Center(
      child: StyleLoadingWidget.foldingCube
          .renderWidget(size: 40.0, color: _primaryColor),
    );
  }
}
