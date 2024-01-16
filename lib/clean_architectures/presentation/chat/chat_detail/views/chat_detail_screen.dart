import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/app_coordinator.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat/chat.dart';
import 'package:lettutor/clean_architectures/domain/entities/tutor_detail/tutor_detail.dart';
import 'package:lettutor/clean_architectures/presentation/chat/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/chat/chat_detail/views/widgets/input_widget.dart';
import 'package:lettutor/clean_architectures/presentation/chat/chat_detail/views/widgets/message_item.dart';
import 'package:lettutor/core/components/constant/image_const.dart';
import 'package:lettutor/core/components/extensions/context_extensions.dart';
import 'package:lettutor/core/components/layout/setting_layout/controller/setting_bloc.dart';
import 'package:lettutor/core/components/widgets/avartat_custom.dart';
import 'package:lettutor/core/components/widgets/image_custom.dart';
import 'package:lettutor/core/components/widgets/pagination_view/default_pagination.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textController = TextEditingController();

  SettingBloc get _settingBloc => context.read<SettingBloc>();

  ChatDetailCubit get _bloc => context.read<ChatDetailCubit>();

  TutorDetail? get _tutor => _bloc.data.tutor;

  List<Chat> get _chats => _bloc.data.chat.rows as List<Chat>;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _bloc.getMessage();
      await _bloc.getTutor();
    });
    super.initState();
  }

  void _listenStateChange(_, ChatDetailState state) {}

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatDetailCubit, ChatDetailState>(
      listener: _listenStateChange,
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            if (ImageConst.chatGround.isNotEmpty)
              Positioned.fill(
                child: ImageCustom(
                  imageUrl: ImageConst.chatGround,
                  fit: BoxFit.cover,
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  isNetworkImage: false,
                ),
              ),
            Positioned.fill(
              child: Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.1)),
            ),
            _body(context, state: state),
          ],
        );
      },
    );
  }

  Widget _body(BuildContext context, {required ChatDetailState state}) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Row(
          children: [
            if (_tutor != null) ...[
              AvatarWidget(
                width: 40.0,
                height: 40.0,
                imageUrl: _tutor?.user?.avatar ?? ImageConst.baseImageView,
              ),
              const SizedBox(width: 10.0),
              Text(
                _tutor!.user?.name ?? "",
                style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: DefaultPagination<Chat>(
              isReverse: true,
              items: _chats,
              loading: state.loading,
              itemBuilder: (_, index) {
                final chat = _chats[index];
                final isSendUser =
                    (_settingBloc.data.currentUser?.id == chat.toInfo.id);
                final userInformation =
                    isSendUser ? chat.fromInfo : chat.toInfo;
                return MessageItem(
                  content: chat.content,
                  time: chat.createdAt,
                  isOp: isSendUser,
                  information: userInformation,
                );
              },
              listenScrollBottom: () async => await _bloc.getMessage(),
            ),
          ),
          InputWidget(
            textEditingController: _textController,
            onSubmitted: () {},
          ),
        ],
      ),
    );
  }
}
