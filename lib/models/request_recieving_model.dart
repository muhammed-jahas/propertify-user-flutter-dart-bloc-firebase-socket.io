import 'package:propertify/models/agent_model.dart';
import 'package:propertify/models/property_model.dart';

class RequestRecievingModel {
  String id;
  String user;
  AgentModel? agent;
  PropertyModel? property;
  String? paymentAmount;
  bool? isPaid;

  RequestRecievingModel({
    required this.id,
    required this.user,
    this.agent,
    this.property,
    this.paymentAmount,
    this.isPaid,
  });

  factory RequestRecievingModel.fromJson(Map<String, dynamic> json) {
    return RequestRecievingModel(
      id: json['_id'],
      user: json['user'],
      agent: json['agent'] != null ? AgentModel.fromJson(json['agent']) : null,
      property: json['property'] != null ? PropertyModel.fromJson(json['property']) : null,
      paymentAmount: json['paymentAmount'],
      isPaid : json['isPaid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'user': user,
      'paymentAmount': paymentAmount,
      'paymentRequestId' : id,
      
    };

    // ignore: unnecessary_null_comparison
    if (id != null) {
      data['_id'] = id;
    }

    if (agent != null) {
      data['agent'] = agent!.toJson(agent!);
    }

    if (property != null) {
      data['property'] = property!.toJson();
    }

    return data;
  }
}