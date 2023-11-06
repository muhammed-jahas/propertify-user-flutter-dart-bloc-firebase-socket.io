class CreateRequest {
  String? userId;
  String? agentId;
  String? propertyId;
  String? requestName;

  CreateRequest({
    this.userId,
    this.agentId,
    this.propertyId,
    this.requestName,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user'] = this.userId;
    data['agent'] = this.agentId;
    data['property'] = this.propertyId;
    data['requestName'] = this.requestName;
    return data;
  }
}
