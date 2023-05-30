import 'package:chat_message/core/chat_controller.dart';
import 'package:chat_message/models/message_model.dart';
import 'package:chat_message/widget/chat_list_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ChatMessage Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  final List<MessageModel> _messageList = [
    MessageModel(
        ownerType: OwnerType.receiver,
        content: 'ChatGPT是否OpenAI研发的聊天机器人程序',
        createdAt: 1772058683000,
        id: 2,
        avatar: 'https://o.devio.org/images/o_as/avatar/tx1.jpeg',
        ownerName: 'ChatGPT'),
    MessageModel(
        ownerType: OwnerType.receiver,
        content: '介绍一下CHatGPT',
        createdAt: 1771058683000,
        id: 1,
        avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
        ownerName: 'Imooc'),
  ];
  late ChatController chatController;

  @override
  void initState() {
    super.initState();
    chatController = ChatController(
        initialMessageList: _messageList,
        scrollController: ScrollController(),
        timePellet: 60);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
              child: ChatList(
            chatController: chatController,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: _loadMore, child: const Text('LoadMore')),
              ElevatedButton(onPressed: _send, child: const Text('Send'))
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void _send() {
    chatController.addMessage(
      MessageModel(
          ownerType: OwnerType.sender,
          content: 'Hello ${count++}',
          createdAt: DateTime.now().millisecondsSinceEpoch,
          avatar: 'https://o.devio.org/images/o_as/avatar/tx1.jpeg',
          ownerName: 'Imooc'),
    );
    Future.delayed(const Duration(milliseconds: 2000), () {
      chatController.addMessage(
        MessageModel(
            ownerType: OwnerType.receiver,
            content: 'Hello',
            createdAt: DateTime.now().millisecondsSinceEpoch,
            avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
            ownerName: 'ChatGPT'),
      );
    });
  }

  int _counter = 0;
  void _loadMore() {
    var tl = 1772058683000;
    tl = tl - ++_counter * 1000000;
    final List<MessageModel> messageList = [
      MessageModel(
          ownerType: OwnerType.sender,
          content: 'Hello ${_counter++}',
          createdAt: DateTime.now().millisecondsSinceEpoch,
          avatar: 'https://o.devio.org/images/o_as/avatar/tx1.jpeg',
          ownerName: 'Imooc'),
      MessageModel(
          ownerType: OwnerType.receiver,
          content: 'Hello',
          createdAt: DateTime.now().millisecondsSinceEpoch,
          avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
          ownerName: 'ChatGPT')
    ];
    chatController.loadMoreData(messageList);
  }
}
