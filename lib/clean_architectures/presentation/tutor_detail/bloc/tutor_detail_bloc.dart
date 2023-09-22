import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';

@injectable
class TutorDetailBloc extends DisposeCallbackBaseBloc {
  final Function1<String, void> getTutorBydId;
  TutorDetailBloc._({
    required Function0<void> dispose,
    required this.getTutorBydId,
  }) : super(dispose);
}
