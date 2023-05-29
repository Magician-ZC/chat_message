import 'package:chat_message/models/message_model.dart';
import 'package:flutter/material.dart';

import '../core/chat_controller.dart';

class ChatList extends StatefulWidget {
  ///Chatlist的控制器
  final ChatController chatController;
  final EdgeInsetsGeometry? padding;

  const ChatList({Key? key, required this.chatController, this.padding})
      : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  ChatController get chatController => widget.chatController;
  ScrollController get scrollController => chatController.scrollController;

  Widget get _chatStreamBuilder => StreamBuilder<List<MessageModel>>(builder:
          (BuildContext context, AsyncSnapshot<List<MessageModel>> snapshot) {
        return snapshot.connectionState == ConnectionState.active
            ? ListView.builder(
                reverse: true,
                padding: widget.padding,
                controller: scrollController,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  var model = snapshot.data![index];
                  //todo
                  return _buildMessageWidget(key: model.key, message: model);
                })
            : const Center(child: CircularProgressIndicator());
      });

  @override
  Widget build(BuildContext context) {
    return _chatStreamBuilder;
  }

  @override
  void initState() {
    super.initState();
    chatController.widgetReady();
  }

  @override
  void dispose() {
    super.dispose();
    chatController.dispose();
  }

  Widget _buildMessageWidget(
      {required GlobalKey<State<StatefulWidget>> key,
      required MessageModel message}) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
          color: message.ownerType == OwnerType.receiver
              ? Colors.amberAccent
              : Colors.blue),
      child: Text('${message.ownerName} ${message.content} ${message.avatar}'),
    );
  }
}
