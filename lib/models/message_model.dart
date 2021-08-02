class MessageModel{
  String phoneUserSender;
  String comment;
  String msgType;
  String timeAdded;
  String voice;
  String images;

  // ignore: sort_constructors_first
  MessageModel({
    this.phoneUserSender,
    this.comment,
    this.msgType,
    this.voice,
    this.images,
    this.timeAdded,
  });
  // ignore: sort_constructors_first
  MessageModel.fromJson(Map<String, dynamic> json) {
    phoneUserSender = json['phone_user_sender'];
    comment = json['comment'];
    msgType = json['msg_type'];
    voice = json['voice_comment'];
    images = json['image_comment'];
    timeAdded = json['timeAdded'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phone_user_sender'] = phoneUserSender;
    data['comment'] = comment;
    data['msg_type'] = msgType;
    data['voice'] = voice;
    data['images'] = images;
    data['timeAdded'] = timeAdded;
    return data;
  }
}

class MessType{
  static String TEXT = 'text';
  static String VOICE = 'voice';
  static String IMAGE = 'image';
}