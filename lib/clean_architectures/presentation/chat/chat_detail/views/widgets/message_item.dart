import 'package:flutter/material.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat_information/chat_information.dart';
import 'package:lettutor/core/components/constant/image_const.dart';
import 'package:lettutor/core/components/extensions/context_extensions.dart';
import 'package:lettutor/core/components/utils/handle_time.dart';
import 'package:lettutor/core/components/widgets/avartat_custom.dart';

class MessageItem extends StatefulWidget {
  final bool isOp;
  final String content;
  final ChatInformation information;
  final DateTime time;
  const MessageItem({
    super.key,
    required this.isOp,
    required this.content,
    required this.time,
    required this.information,
  });

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    final style = context.titleSmall.copyWith(
      fontSize: 13.0,
      color: widget.isOp ? context.titleLarge.color : Colors.white,
    );
    var content = [
      Flexible(
        flex: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment:
              widget.isOp ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            if (widget.isOp) ...[
              _chatBotInformation(context),
              const SizedBox(height: 5.0),
            ],
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: widget.isOp
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(widget.content, style: style),
            ),
            const SizedBox(height: 2.0),
            Text(
              "${getYmdFormat(widget.time)} ${getjmFormat(widget.time)}",
              style: context.titleSmall
                  .copyWith(fontSize: 12.0, color: Theme.of(context).hintColor),
            )
          ],
        ),
      ),
      SizedBox(width: context.widthDevice * 0.15)
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            widget.isOp ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: widget.isOp ? content : content.reversed.toList(),
      ),
    );
  }

  Widget _chatBotInformation(BuildContext context) {
    return Row(
      children: [
        AvatarWidget(
          width: 20.0,
          height: 20.0,
          imageUrl: widget.information.avatar ?? ImageConst.baseImageView,
        ),
        const SizedBox(width: 5.0),
        Text(
          widget.information.name,
          style: context.titleSmall.copyWith(fontSize: 12.0),
        ),
      ],
    );
  }
}
