import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/app_coordinator.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat/chat.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat_information/chat_information.dart';
import 'package:lettutor/clean_architectures/domain/entities/user/user.dart';
import 'package:lettutor/clean_architectures/presentation/chat/recipient/bloc/recipient_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/chat/recipient/bloc/recipient_data.dart';
import 'package:lettutor/core/components/constant/image_const.dart';
import 'package:lettutor/core/components/extensions/context_extensions.dart';
import 'package:lettutor/core/components/layout/setting_layout/controller/setting_bloc.dart';
import 'package:lettutor/core/components/utils/handle_time.dart';
import 'package:lettutor/core/components/widgets/avartat_custom.dart';
import 'package:lettutor/core/components/widgets/loading_page.dart';
import 'package:lettutor/generated/l10n.dart';

class RecipientScreen extends StatefulWidget {
  const RecipientScreen({super.key});

  @override
  State<RecipientScreen> createState() => _RecipientScreenState();
}

class _RecipientScreenState extends State<RecipientScreen> {
  SettingBloc get _settingBloc => context.read<SettingBloc>();

  User? get _user => _settingBloc.data.currentUser;

  RecipientCubit get _bloc => context.read<RecipientCubit>();

  RecipientData get _data => _bloc.data;

  List<Chat> get _recipients => _data.recipients;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _bloc.onGetRecipient();
    });
    super.initState();
  }

  void _listenStateChange(_, RecipientState state) {}

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipientCubit, RecipientState>(
      listener: _listenStateChange,
      builder: (context, state) {
        return Stack(
          children: [
            _body(context),
            if (state.loading)
              Container(
                color: Colors.black45,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: _loadingFunction(),
              )
          ],
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
        title: Text(
          S.of(context).recipients,
          style: context.titleLarge
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Theme.of(context).primaryColor.withOpacity(0.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text("HotLine",
                        style:
                            context.titleMedium.copyWith(color: Colors.white)),
                    Expanded(
                      child: Text(
                        "0945 337 337",
                        textAlign: TextAlign.end,
                        style: context.titleLarge.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(ImageConst.icon,
                          width: 40.0, height: 40.0, fit: BoxFit.cover),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.chat_bubble_2_fill,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 8.0),
                          Text(
                            "Messenger",
                            style: context.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              itemCount: _recipients.length,
              itemBuilder: (context, index) {
                final chat = _recipients[index];
                final userInformation =
                    (_user?.id == chat.toInfo.id) ? chat.fromInfo : chat.toInfo;
                return _chatItemBuilder(userInformation, context, chat);
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _chatItemBuilder(
      ChatInformation userInformation, BuildContext context, Chat chat) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: [
          AvatarWidget(
            imageUrl: userInformation.avatar ?? ImageConst.baseImageView,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userInformation.name,
                  style:
                      context.titleMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(
                  chat.content,
                  style: context.titleSmall.copyWith(
                    fontSize: 12.0,
                    color: (chat.isRead)
                        ? Theme.of(context).hintColor
                        : context.titleLarge.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  getjmFormat(chat.updatedAt ?? DateTime.now()),
                  style: context.titleSmall.copyWith(
                      fontSize: 12.0, color: Theme.of(context).hintColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Center _loadingFunction() {
    return Center(
      child: StyleLoadingWidget.foldingCube
          .renderWidget(size: 40.0, color: Theme.of(context).primaryColor),
    );
  }
}
