import 'package:flutter/material.dart';
import 'package:lettutor/clean_architectures/presentation/chat/recipient/bloc/recipient_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/chat/recipient/views/recipient_screen.dart';
import 'package:lettutor/core/components/layout/setting_layout/controller/setting_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/dependency_injection/di.dart';

extension BlocExtension<T> on BuildContext {
  SettingBloc get readSettingBloc => read<SettingBloc>();
}

Widget get createRecipientBloc => BlocProvider<RecipientCubit>(
      create: (_) => injector.get<RecipientCubit>(),
      child: const RecipientScreen(),
    );
