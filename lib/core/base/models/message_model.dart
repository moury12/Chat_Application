class MessageModel {
  String? sId;
  String? from;
  String? to;
  String? message;
  String? timeStamp;
  int? iV;

  MessageModel(
      {this.sId, this.from, this.to, this.message, this.timeStamp, this.iV});

  MessageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    from = json['from'];
    to = json['to'];
    message = json['message'];
    timeStamp = json['timeStamp'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['from'] = from;
    data['to'] = to;
    data['message'] = message;
    data['timeStamp'] = timeStamp;
    data['__v'] = iV;
    return data;
  }
}
