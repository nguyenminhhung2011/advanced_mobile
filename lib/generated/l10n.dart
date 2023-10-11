// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `update`
  String get update {
    return Intl.message(
      'update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get seeMore {
    return Intl.message(
      'See more',
      name: 'seeMore',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Currencies`
  String get currencies {
    return Intl.message(
      'Currencies',
      name: 'currencies',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get darkTheme {
    return Intl.message(
      'Dark theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light theme`
  String get lightTheme {
    return Intl.message(
      'Light theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Code and fingerprint`
  String get codeAndFingerPrints {
    return Intl.message(
      'Code and fingerprint',
      name: 'codeAndFingerPrints',
      desc: '',
      args: [],
    );
  }

  /// `Lock and Security`
  String get lockAndSecurity {
    return Intl.message(
      'Lock and Security',
      name: 'lockAndSecurity',
      desc: '',
      args: [],
    );
  }

  /// `General settings`
  String get generalSettings {
    return Intl.message(
      'General settings',
      name: 'generalSettings',
      desc: '',
      args: [],
    );
  }

  /// `By Price`
  String get byPrice {
    return Intl.message(
      'By Price',
      name: 'byPrice',
      desc: '',
      args: [],
    );
  }

  /// `Enter code`
  String get enterCode {
    return Intl.message(
      'Enter code',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `Error code`
  String get errorCode {
    return Intl.message(
      'Error code',
      name: 'errorCode',
      desc: '',
      args: [],
    );
  }

  /// `Become tutor`
  String get becomeTutor {
    return Intl.message(
      'Become tutor',
      name: 'becomeTutor',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to use letTutor`
  String get signUpToUse {
    return Intl.message(
      'Sign up to use letTutor',
      name: 'signUpToUse',
      desc: '',
      args: [],
    );
  }

  /// `Register account to use all features of letTutor`
  String get registerAccountToUse {
    return Intl.message(
      'Register account to use all features of letTutor',
      name: 'registerAccountToUse',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `register account`
  String get registerAccount {
    return Intl.message(
      'register account',
      name: 'registerAccount',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address to search for your account`
  String get pleaseEnterYourEmail {
    return Intl.message(
      'Please enter your email address to search for your account',
      name: 'pleaseEnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Say hello to your English tutors`
  String get sayHellToYour {
    return Intl.message(
      'Say hello to your English tutors',
      name: 'sayHellToYour',
      desc: '',
      args: [],
    );
  }

  /// `Become fluent faster through one on one video chat lessons tailored to your goals`
  String get beComeFluent {
    return Intl.message(
      'Become fluent faster through one on one video chat lessons tailored to your goals',
      name: 'beComeFluent',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password`
  String get forGotPassword {
    return Intl.message(
      'Forgot your password',
      name: 'forGotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Or continue with`
  String get orContinue {
    return Intl.message(
      'Or continue with',
      name: 'orContinue',
      desc: '',
      args: [],
    );
  }

  /// `Registering`
  String get registering {
    return Intl.message(
      'Registering',
      name: 'registering',
      desc: '',
      args: [],
    );
  }

  /// `Tutor registering`
  String get tutorRegister {
    return Intl.message(
      'Tutor registering',
      name: 'tutorRegister',
      desc: '',
      args: [],
    );
  }

  /// `Introduction`
  String get introduction {
    return Intl.message(
      'Introduction',
      name: 'introduction',
      desc: '',
      args: [],
    );
  }

  /// `Language I speak`
  String get language {
    return Intl.message(
      'Language I speak',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Who i tech`
  String get whoITech {
    return Intl.message(
      'Who i tech',
      name: 'whoITech',
      desc: '',
      args: [],
    );
  }

  /// `Interests`
  String get interests {
    return Intl.message(
      'Interests',
      name: 'interests',
      desc: '',
      args: [],
    );
  }

  /// `Enter your interest`
  String get EnterYourInterests {
    return Intl.message(
      'Enter your interest',
      name: 'EnterYourInterests',
      desc: '',
      args: [],
    );
  }

  /// `Experiences`
  String get experiences {
    return Intl.message(
      'Experiences',
      name: 'experiences',
      desc: '',
      args: [],
    );
  }

  /// `Enter your experience`
  String get EnterYourExperiences {
    return Intl.message(
      'Enter your experience',
      name: 'EnterYourExperiences',
      desc: '',
      args: [],
    );
  }

  /// `Professions`
  String get professions {
    return Intl.message(
      'Professions',
      name: 'professions',
      desc: '',
      args: [],
    );
  }

  /// `Basic info`
  String get basicInfo {
    return Intl.message(
      'Basic info',
      name: 'basicInfo',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message(
      'Bio',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Report tutor`
  String get reportTutor {
    return Intl.message(
      'Report tutor',
      name: 'reportTutor',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Add report content`
  String get addReportContent {
    return Intl.message(
      'Add report content',
      name: 'addReportContent',
      desc: '',
      args: [],
    );
  }

  /// `Add review`
  String get addReview {
    return Intl.message(
      'Add review',
      name: 'addReview',
      desc: '',
      args: [],
    );
  }

  /// `Your review`
  String get yourReview {
    return Intl.message(
      'Your review',
      name: 'yourReview',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get schedule {
    return Intl.message(
      'Schedule',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `Write your review...`
  String get writeYourReview {
    return Intl.message(
      'Write your review...',
      name: 'writeYourReview',
      desc: '',
      args: [],
    );
  }

  /// `Rate star`
  String get rateStar {
    return Intl.message(
      'Rate star',
      name: 'rateStar',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `🌟 Welcome to LetTutor`
  String get welcomeToLetTutor {
    return Intl.message(
      '🌟 Welcome to LetTutor',
      name: 'welcomeToLetTutor',
      desc: '',
      args: [],
    );
  }

  /// `Tutor search`
  String get tutorSearch {
    return Intl.message(
      'Tutor search',
      name: 'tutorSearch',
      desc: '',
      args: [],
    );
  }

  /// `Search here`
  String get searchHere {
    return Intl.message(
      'Search here',
      name: 'searchHere',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message(
      'Nationality',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `Topics`
  String get topics {
    return Intl.message(
      'Topics',
      name: 'topics',
      desc: '',
      args: [],
    );
  }

  /// `All e-book`
  String get allEBoo {
    return Intl.message(
      'All e-book',
      name: 'allEBoo',
      desc: '',
      args: [],
    );
  }

  /// `View e-book`
  String get viewEBoo {
    return Intl.message(
      'View e-book',
      name: 'viewEBoo',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Meeting settings`
  String get meetingSettings {
    return Intl.message(
      'Meeting settings',
      name: 'meetingSettings',
      desc: '',
      args: [],
    );
  }

  /// `JoinMeeting `
  String get joinMeeting {
    return Intl.message(
      'JoinMeeting ',
      name: 'joinMeeting',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `All levels`
  String get allLevels {
    return Intl.message(
      'All levels',
      name: 'allLevels',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Lesson date`
  String get lessonDate {
    return Intl.message(
      'Lesson date',
      name: 'lessonDate',
      desc: '',
      args: [],
    );
  }

  /// `Start time`
  String get startTime {
    return Intl.message(
      'Start time',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `End time`
  String get endTime {
    return Intl.message(
      'End time',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Profile preview`
  String get profilePreview {
    return Intl.message(
      'Profile preview',
      name: 'profilePreview',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get seconds {
    return Intl.message(
      'seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `overview`
  String get overview {
    return Intl.message(
      'overview',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get courses {
    return Intl.message(
      'Courses',
      name: 'courses',
      desc: '',
      args: [],
    );
  }

  /// `Experience level`
  String get experienceLevel {
    return Intl.message(
      'Experience level',
      name: 'experienceLevel',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get test {
    return Intl.message(
      'Test',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Search tutor result`
  String get searchTutorResult {
    return Intl.message(
      'Search tutor result',
      name: 'searchTutorResult',
      desc: '',
      args: [],
    );
  }

  /// `UpComing`
  String get upComing {
    return Intl.message(
      'UpComing',
      name: 'upComing',
      desc: '',
      args: [],
    );
  }

  /// `Book tutor`
  String get bookTutor {
    return Intl.message(
      'Book tutor',
      name: 'bookTutor',
      desc: '',
      args: [],
    );
  }

  /// `Tutor detailr`
  String get tutorDetail {
    return Intl.message(
      'Tutor detailr',
      name: 'tutorDetail',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Is favorite`
  String get isFavorite {
    return Intl.message(
      'Is favorite',
      name: 'isFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Enter your education`
  String get enterEducation {
    return Intl.message(
      'Enter your education',
      name: 'enterEducation',
      desc: '',
      args: [],
    );
  }

  /// `Specialties`
  String get specialties {
    return Intl.message(
      'Specialties',
      name: 'specialties',
      desc: '',
      args: [],
    );
  }

  /// `Suggested courses`
  String get suggestedCourses {
    return Intl.message(
      'Suggested courses',
      name: 'suggestedCourses',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterYourName {
    return Intl.message(
      'Enter your name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Birth day`
  String get birthDay {
    return Intl.message(
      'Birth day',
      name: 'birthDay',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `User information`
  String get userInformation {
    return Intl.message(
      'User information',
      name: 'userInformation',
      desc: '',
      args: [],
    );
  }

  /// `Study schedule`
  String get studySchedule {
    return Intl.message(
      'Study schedule',
      name: 'studySchedule',
      desc: '',
      args: [],
    );
  }

  /// `Enter study schedule`
  String get enterStudySchedule {
    return Intl.message(
      'Enter study schedule',
      name: 'enterStudySchedule',
      desc: '',
      args: [],
    );
  }

  /// `User levels`
  String get userLevels {
    return Intl.message(
      'User levels',
      name: 'userLevels',
      desc: '',
      args: [],
    );
  }

  /// `Topics and Preparations`
  String get topicsAndPreparations {
    return Intl.message(
      'Topics and Preparations',
      name: 'topicsAndPreparations',
      desc: '',
      args: [],
    );
  }

  /// `Update profile`
  String get updateProfile {
    return Intl.message(
      'Update profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Total lessons times is `
  String get totalLessonsTimesIs {
    return Intl.message(
      'Total lessons times is ',
      name: 'totalLessonsTimesIs',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any upcoming class`
  String get donHaveAnyUpcoming {
    return Intl.message(
      'Don\'t have any upcoming class',
      name: 'donHaveAnyUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `Tutor`
  String get tutor {
    return Intl.message(
      'Tutor',
      name: 'tutor',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get showMore {
    return Intl.message(
      'Show more',
      name: 'showMore',
      desc: '',
      args: [],
    );
  }

  /// `Show less`
  String get showLess {
    return Intl.message(
      'Show less',
      name: 'showLess',
      desc: '',
      args: [],
    );
  }

  /// `report`
  String get Report {
    return Intl.message(
      'report',
      name: 'Report',
      desc: '',
      args: [],
    );
  }

  /// `Tutor schedule`
  String get tutorSchedule {
    return Intl.message(
      'Tutor schedule',
      name: 'tutorSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Created at`
  String get createdAt {
    return Intl.message(
      'Created at',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `Updated at`
  String get updatedAt {
    return Intl.message(
      'Updated at',
      name: 'updatedAt',
      desc: '',
      args: [],
    );
  }

  /// `All topics`
  String get allTopics {
    return Intl.message(
      'All topics',
      name: 'allTopics',
      desc: '',
      args: [],
    );
  }

  /// `Why take this course?`
  String get whatTTCourses {
    return Intl.message(
      'Why take this course?',
      name: 'whatTTCourses',
      desc: '',
      args: [],
    );
  }

  /// `What will you be able to do?`
  String get whatWYBe {
    return Intl.message(
      'What will you be able to do?',
      name: 'whatWYBe',
      desc: '',
      args: [],
    );
  }

  /// `UpComing lessons will appear`
  String get upComingLessonsWillAppear {
    return Intl.message(
      'UpComing lessons will appear',
      name: 'upComingLessonsWillAppear',
      desc: '',
      args: [],
    );
  }

  /// `Enter your bio`
  String get enterYourBio {
    return Intl.message(
      'Enter your bio',
      name: 'enterYourBio',
      desc: '',
      args: [],
    );
  }

  /// `Tap to selected avatar`
  String get tapToSelectedAvatar {
    return Intl.message(
      'Tap to selected avatar',
      name: 'tapToSelectedAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Your Tutor profile is your chance to mar yourself to students on Tutoring`
  String get yourTutorProfile {
    return Intl.message(
      'Your Tutor profile is your chance to mar yourself to students on Tutoring',
      name: 'yourTutorProfile',
      desc: '',
      args: [],
    );
  }

  /// `Enter your professions`
  String get EnterYourProfessions {
    return Intl.message(
      'Enter your professions',
      name: 'EnterYourProfessions',
      desc: '',
      args: [],
    );
  }

  /// `Students will view this information on your profile to decide if you're good fit for them Yeah yeah yeah`
  String get studentsWillViewThisInformation {
    return Intl.message(
      'Students will view this information on your profile to decide if you\'re good fit for them Yeah yeah yeah',
      name: 'studentsWillViewThisInformation',
      desc: '',
      args: [],
    );
  }

  /// `My specialties are`
  String get mySpecialtiesAre {
    return Intl.message(
      'My specialties are',
      name: 'mySpecialtiesAre',
      desc: '',
      args: [],
    );
  }

  /// `I am a best at teaching students who are`
  String get iAmABestAtTeaching {
    return Intl.message(
      'I am a best at teaching students who are',
      name: 'iAmABestAtTeaching',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
