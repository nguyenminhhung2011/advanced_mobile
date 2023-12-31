import 'package:flutter/material.dart';
import 'package:lettutor/core/components/layout/setting_layout/controller/setting_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocExtension<T> on BuildContext {
  SettingBloc get readSettingBloc => read<SettingBloc>();
}
