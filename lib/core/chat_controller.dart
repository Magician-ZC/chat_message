import 'dart:async';

import 'package:chat_message/models/message_model.dart';
import 'package:flutter/cupertino.dart';

class ChatController implements IChatController {
  ///初始化数据
  final List<MessageModel> initialMessageList;
  final ScrollController scrollController;

  ChatController(
      {required this.initialMessageList, required this.scrollController});

  StreamController<List<MessageModel>> messageStramController =
      StreamController();

  void dispose() {
    messageStramController.close();
    scrollController.dispose();
  }

  void widgetReady() {
    if (!messageStramController.isClosed) {
      messageStramController.sink.add(initialMessageList);
    }
    if (initialMessageList.isNotEmpty) {
      scrollToLastMessage();
    }
  }

  @override
  void addMessage(MessageModel message) {
    if (messageStramController.isClosed) return;
    //List反转后列是从底部向上展示，所以新来的消息需要插入到数据第0个位置
    initialMessageList.insert(0, message);
    messageStramController.sink.add(initialMessageList);
    scrollToLastMessage();
  }

  @override
  void loadMoreData(List<MessageModel> messageList) {
    // TODO: implement loadMoreData
  }

  void scrollToLastMessage() {
    //todo
  }
}

abstract class IChatController {
  void addMessage(MessageModel message);
  void loadMoreData(List<MessageModel> messageList);
}
