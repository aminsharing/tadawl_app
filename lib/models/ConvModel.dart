class ConvModel {
  String? id_conv;
  String? phone_user_recipient;
  String? phone_user_sender;
  String? id_comment;
  String? seen_reciever;
  String? seen_sender;
  String? state_conv_receiver;
  String? state_conv_sender;
  String? comment;
  String? timeAdded;
  String? username;
  String? image;
  String? phone;
  String? unreadMsgs;
  String? msgType;
  String? voice;
  int? duration;
  bool? isBlocked;
  bool? isLocal;
  // ignore: sort_constructors_first
  ConvModel({
        this.id_conv,
        this.phone_user_recipient,
        this.phone_user_sender,
        this.id_comment,
        this.seen_reciever,
        this.seen_sender,
        this.state_conv_receiver,
        this.state_conv_sender,
        this.comment,
        this.timeAdded,
        this.username,
        this.image,
        this.phone,
        this.voice,
        this.duration,
        this.msgType,
        this.unreadMsgs,
        this.isBlocked,
        this.isLocal,
  });
  // ignore: sort_constructors_first
  ConvModel.fromJson(Map<String, dynamic> json) {
    id_conv = json['id_conv'];
    phone_user_recipient = json['phone_user_recipient'];
    phone_user_sender = json['phone_user_sender'];
    id_comment = json['id_comment'];
    seen_reciever = json['seen_reciever'];
    seen_sender = json['seen_sender'];
    state_conv_receiver = json['state_conv_receiver'];
    state_conv_sender = json['state_conv_sender'];
    comment = json['comment'];
    timeAdded = json['timeAdded'];
    username = json['username'];
    image = json['image'];
    phone = json['phone'];
    msgType = json['msg_type'];
    voice = json['voice_comment'];
    isBlocked = json['blocked'] == '1';
    duration = int.tryParse(json['voice_duration']??'0');
    isLocal = false;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_conv'] = id_conv;
    data['phone_user_recipient'] = phone_user_recipient;
    data['phone_user_sender'] = phone_user_sender;
    data['id_comment'] = id_comment;
    data['seen_reciever'] = seen_reciever;
    data['seen_sender'] = seen_sender;
    data['state_conv_receiver'] = state_conv_receiver;
    data['state_conv_sender'] = state_conv_sender;
    data['comment'] = comment;
    data['timeAdded'] = timeAdded;
    data['username'] = username;
    data['image'] = image;
    data['phone'] = phone;
    data['msg_type'] = msgType;
    data['voice_comment'] = voice;
    data['voice_duration'] = duration;
    isLocal = false;
    return data;
  }
}
