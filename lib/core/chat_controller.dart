import 'dart:async';

import 'package:chat_message/models/message_model.dart';
import 'package:flutter/cupertino.dart';

class ChatController implements IChatController {
  ///初始化数据
  final List<MessageModel> initialMessageList;
  final ScrollController scrollController;

  ///展示时间的间隔，单位秒
  final int timePellet;
  List<int> pelletShow = [];

  ChatController(
      {required this.initialMessageList,
      required this.scrollController,
      required this.timePellet}) {
    for (var message in initialMessageList.reversed) {
      inflateMessage(message);
    }
  }

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
    inflateMessage(message);
    //List反转后列是从底部向上展示，所以新来的消息需要插入到数据第0个位置
    initialMessageList.insert(0, message);
    messageStramController.sink.add(initialMessageList);
    scrollToLastMessage();
  }

  @override
  void loadMoreData(List<MessageModel> messageList) {
    //List反转后列是从底部向上展示，所以消息顺序也需要进行反转
    messageList = List.from(messageList.reversed);
    List<MessageModel> tempList = [...initialMessageList, ...messageList];
    //clear record and redo
    pelletShow.clear();
    //时间的标记是从最久的消息开始
    for (var message in tempList.reversed) {
      inflateMessage(message);
    }
    initialMessageList.clear();
    initialMessageList.addAll(tempList);
    if (messageStramController.isClosed) return;
    messageStramController.sink.add(initialMessageList);
  }

  void scrollToLastMessage() {
    if (!scrollController.hasClients) {
      return;
    }
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  ///设置消息的时间是否可以展示
  void inflateMessage(MessageModel message) {
    int pellet = (message.createdAt / (timePellet * 1000)).truncate();
    if (!pelletShow.contains(pellet)) {
      pelletShow.add(pellet);
      message.showCreatedTime = true;
    } else {
      message.showCreatedTime = false;
    }
  }
}

abstract class IChatController {
  void addMessage(MessageModel message);
  void loadMoreData(List<MessageModel> messageList);
}
