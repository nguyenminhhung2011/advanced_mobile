import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/tutor_schedule/tutor_schedule_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_schedule/bloc/tutor_schedule_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@injectable
class TutorScheduleBloc extends DisposeCallbackBaseBloc {
  ///[Functions]
  final Function0<void> fetchTutorSchedule;

  final Function2<DateTime, DateTime, void> selectedTime;

  final Function2<String, String, void> booTutorClass;

  ///[Streams]

  final Stream<bool?> loading$;

  final Stream<bool?> loadingBooTutorClass$;

  final Stream<DateTime> startTime$;

  final Stream<DateTime> endTime$;

  final Stream<TutorScheduleState> state$;

  final Stream<List<Schedule>> schedule$;

  TutorScheduleBloc._({
    required Function0<void> dispose,
    required this.loadingBooTutorClass$,
    required this.fetchTutorSchedule,
    required this.booTutorClass,
    required this.selectedTime,
    required this.startTime$,
    required this.schedule$,
    required this.endTime$,
    required this.loading$,
    required this.state$,
  }) : super(dispose);

  factory TutorScheduleBloc(@factoryParam String userId,
      {required TutorScheduleUseCase tutorScheduleUseCase}) {
    ///[Defines values]

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final loadingBooTutorController = BehaviorSubject<bool>.seeded(false);

    final noteController = BehaviorSubject<String>.seeded("");

    final scheduleIdController = BehaviorSubject<String>.seeded("");

    final scheduleController =
        BehaviorSubject.seeded(List<Schedule>.empty(growable: true));

    final startTimeController = BehaviorSubject<DateTime>.seeded(
        DateTime.now().subtract(const Duration(days: 2)));

    final endTimeController = BehaviorSubject<DateTime>.seeded(
        DateTime.now().add(const Duration(days: 5)));

    ///[Actions]

    final fetchTutorScheduleController = PublishSubject<void>();

    final booTutorClassController = PublishSubject<void>();

    ///[Handle actions]

    final isValid$ = Rx.combineLatest3(
      loadingController.stream,
      startTimeController.stream,
      endTimeController.stream,
      (loading, sT, eT) => !loading && sT.isBefore(eT),
    ).shareValueSeeded(false);

    final fetchTutorSchedule$ = fetchTutorScheduleController.stream
        .withLatestFrom(isValid$, (_, isValid) => isValid)
        .share();

    final fetchTutorScheduleState$ = Rx.merge<TutorScheduleState>([
      fetchTutorSchedule$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .withLatestFrom(
            Rx.combineLatest2(startTimeController.stream,
                endTimeController.stream, (sT, eT) => {'sT': sT, 'eT': eT}),
            (_, timeData) => timeData,
          )
          .exhaustMap((timeData) {
        final sT =
            timeData['sT'] ?? DateTime.now().subtract(const Duration(days: 1));
        final eT =
            timeData['eT'] ?? DateTime.now().add(const Duration(days: 5));
        try {
          return tutorScheduleUseCase
              .getTutorSchedule(tutorId: userId, startTime: sT, endTime: eT)
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
                    ifLeft: (error) => GetTutorScheduleFailed(
                        message: error.message, error: error.code),
                    ifRight: (sData) {
                      scheduleController.add(sData);
                      return const GetTutorScheduleSuccess();
                    }),
              );
        } catch (e) {
          return Stream<TutorScheduleState>.error(
            GetTutorScheduleFailed(message: e.toString()),
          );
        }
      }),
      fetchTutorSchedule$
          .where((isValid) => !isValid)
          .map((_) => const GetTutorScheduleFailed())
    ]).whereNotNull().share();

    ///[Boo tutor class]
    ///
    final booTutorValid$ = Rx.combineLatest3(
            scheduleIdController.stream,
            noteController.stream,
            loadingBooTutorController.stream,
            (scheduleId, note, loading) =>
                scheduleId.isNotEmpty && note.isNotEmpty && !loading)
        .shareValueSeeded(false);

    final booTutorClass$ = booTutorClassController.stream
        .withLatestFrom(booTutorValid$, (_, isValid) => isValid)
        .share();

    final booTutorClassState$ = Rx.merge<TutorScheduleState>([
      booTutorClass$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .withLatestFrom(
              Rx.combineLatest2(
                  scheduleIdController.stream,
                  noteController.stream,
                  (scheduleId, note) =>
                      {'scheduleId': scheduleId, 'note': note}),
              (_, data) => data)
          .exhaustMap((mapData) {
        final scheduleId = mapData['scheduleId'] ?? '';
        final note = mapData['note'] ?? '';
        if (scheduleId.isEmpty || note.isEmpty) {
          return Stream<TutorScheduleState>.error(
            const BooTutorClassFailed(message: 'Input data null'),
          );
        }
        try {
          return tutorScheduleUseCase
              .booTutorClass(scheduleDetailIds: [scheduleId], note: note)
              .doOn(
                listen: () => loadingBooTutorController.add(true),
                cancel: () => loadingBooTutorController.add(false),
              )
              .map((data) => data.fold(
                  ifLeft: (error) => BooTutorClassFailed(
                      message: error.message, error: error.code),
                  ifRight: (rData) {
                    if (rData) {
                      final currentData = scheduleController.value;
                      scheduleController.add(currentData.where((e) {
                        if (e.scheduleDetails.isEmpty) return true;
                        return e.scheduleDetails.first.id != scheduleId;
                      }).toList());
                      return const BooTutorClassSuccess();
                    }
                    return const BooTutorClassFailed(
                      message: 'boo tutor class failed',
                    );
                  }));
        } catch (e) {
          return Stream<TutorScheduleState>.error(
            BooTutorClassFailed(message: e.toString()),
          );
        }
      }),
      booTutorClass$
          .where((isValid) => !isValid)
          .map((_) => const BooTutorClassFailed(message: "Invalid format"))
    ]).whereNotNull().share();

    final state$ = Rx.merge<TutorScheduleState>(
        [fetchTutorScheduleState$, booTutorClassState$]).whereNotNull().share();

    final subscriptions = <String, Stream>{
      'state': state$,
      'loadingController': loadingController,
      'isValid': isValid$,
      'booTutorValid': booTutorValid$,
    }.debug();

    return TutorScheduleBloc._(
      dispose: () async => await DisposeBag([
        loadingController,
        scheduleController,
        startTimeController,
        endTimeController,
        fetchTutorScheduleController,
        loadingBooTutorController,
        noteController,
        booTutorClassController,
        scheduleIdController,
        ...subscriptions,
      ]).dispose(),
      fetchTutorSchedule: () => fetchTutorScheduleController.add(null),
      startTime$: startTimeController,
      schedule$: scheduleController,
      endTime$: endTimeController,
      booTutorClass: (scheduleId, note) {
        scheduleIdController.add(scheduleId);
        noteController.add(note);
        booTutorClassController.add(null);
      },
      loadingBooTutorClass$: loadingBooTutorController,
      loading$: loadingController,
      selectedTime: (sT, eT) {
        startTimeController.add(sT);
        endTimeController.add(eT);
        fetchTutorScheduleController.add(null);
      },
      state$: state$,
    );
  }
}
