import 'package:disposebag/disposebag.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/main/main_usecase.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainBloc extends DisposeCallbackBaseBloc {
  MainBloc._({required Function0<void> dispose}) : super(dispose);

  factory MainBloc({required MainUseCase mainUseCase}) {
    return MainBloc._(dispose: () async => await DisposeBag().dispose());
  }
}
