import 'package:flutter/material.dart';
import 'package:lettutor/clean_architectures/presentation/chat/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/chat/chat_detail/views/chat_detail_screen.dart';
import 'package:lettutor/clean_architectures/presentation/chat/recipient/bloc/recipient_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/chat/recipient/views/recipient_screen.dart';
import 'package:lettutor/core/components/layout/setting_layout/controller/setting_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/components/network/soc/app_soc.dart';
import 'package:lettutor/core/dependency_injection/di.dart';

extension BlocExtension<T> on BuildContext {
  SettingBloc get readSettingBloc => read<SettingBloc>();
  AppSoc get readAppSoc => read<AppSoc>();
}

Widget get createRecipientBloc => BlocProvider<RecipientCubit>(
      create: (_) => injector.get<RecipientCubit>(),
      child: const RecipientScreen(),
    );
Widget createChatBloc(String id) => BlocProvider<ChatDetailCubit>(
      create: (_) => injector.get<ChatDetailCubit>(param1: id),
      child: const ChatDetailScreen(),
    );
