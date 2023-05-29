import 'package:chat_message/core/chat_controller.dart';
import 'package:chat_message/models/message_model.dart';
import 'package:chat_message/widget/chat_list.dart';
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final List<MessageModel> _messageList = [
    MessageModel(
        ownerType: OwnerType.receiver,
        content: 'ChatGPT是否OpenAI研发的聊天机器人程序',
        createAt: 1772058683000,
        id: 2,
        avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
        ownerName: 'ChatGPT'),
    MessageModel(
        ownerType: OwnerType.receiver,
        content: '介绍',
        createAt: 1771058683000,
        id: 1,
        avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
        ownerName: 'ChatGPT'),
  ];
  late ChatController chatController;

  @override
  void initState() {
    super.initState();
    chatController = ChatController(
        initialMessageList: _messageList, scrollController: ScrollController());
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
        ],
      ),
    );
  }
}
