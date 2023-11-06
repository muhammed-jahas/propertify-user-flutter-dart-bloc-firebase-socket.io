class AgentModel {
  String id;
  String? name;
  String? email;
  String? phone;
  bool? status;
  String? image;

  AgentModel({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.status,
    this.image,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) => AgentModel(
        id: json['_id'],
        name: json['fullname'],
        email: json['email'],
        phone: json['mobNo'],
        image: json['image'],
        status: json['status'] ?? false,
      );

  Map<String, dynamic> toJson(AgentModel agent) => {
        '_id': agent.id,
        'fullname': agent.name,
        'email': agent.email,
        'mobNo': agent.phone,
        'image': agent.image,
        'status': agent.status,
      };
}
