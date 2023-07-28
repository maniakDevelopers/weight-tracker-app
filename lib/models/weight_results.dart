class WeightModel {
  final String id;
  final String userid;
  final String weight;
  final String weighed_on;

  WeightModel(this.id, this.userid, this.weight, this.weighed_on);

  WeightModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        userid = json['userId'],
        weight = json['weight'],
        weighed_on = json['weighed_on'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userid,
        'weight': weight,
        'weighed_on': weighed_on,
      };
}

class WeightResult {
  final bool status;
  final List<WeightModel> success;

  WeightResult(this.status, this.success);

  WeightResult.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        success = json['success'];

  Map<String, dynamic> toJson() => {
        'status': status,
        'success': success,
      };
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
