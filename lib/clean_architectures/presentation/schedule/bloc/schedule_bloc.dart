import 'package:disposebag/disposebag.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScheduleBloc extends DisposeCallbackBaseBloc {
  ScheduleBloc._({required Function0<void> dispose}) : super(dispose);

  factory ScheduleBloc() {
    return ScheduleBloc._(dispose: () async => await DisposeBag().dispose());
  }
}
