import 'package:flutter/material.dart';

enum OwnerType { receiver, sender }

///枚举类型在数据库保存为string，取出时转成枚举
OwnerType _of(String name) {
  if (name == OwnerType.receiver.toString()) {
    return OwnerType.receiver;
  } else {
    return OwnerType.sender;
  }
}

class MessageModel {
  final int? id;

  ///为了避免添加数据的时候重新刷新问题
  final GlobalKey key;

  ///消息发送方和接收方的标识，用于决定消息展示在哪一侧
  final OwnerType ownerType;

  ///消息发送方的名字
  final String? ownerName;

  ///头像url
  final String? avatar;

  ///消息内容
  final String content;

  ///消息创建时间
  final int createAt;

  ///是否显示时间
  bool showCreatedTime = false;

  MessageModel(
      {this.id,
      required this.ownerType,
      this.ownerName,
      this.avatar,
      required this.content,
      required this.createAt})
      : key = GlobalKey();

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      ownerType: _of(json['ownerType']),
      content: json['content'],
      ownerName: json['ownerName'],
      createAt: json['createAt'],
      avatar: json['avatar'],
      id: json['id']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'ownerType': ownerType.toString(),
        'content': content,
        'ownerName': ownerName,
        'createAt': createAt,
        'avatar': avatar,
      };
}
