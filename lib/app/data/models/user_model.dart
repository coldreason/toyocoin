import '../../../constants.dart';

class UserModel {
  final String name;
  final String introduce;
  final bool hasRoute;

  UserModel({required this.name,required this.introduce,required this.hasRoute});

  UserModel.fromJson(Map<String, Object?> json)
      : this(
      name: json[FirestoreConstants.name]! as String,
      introduce: json[FirestoreConstants.introduce]! as String,
    hasRoute: json[FirestoreConstants.introduce]! as bool,
  );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[FirestoreConstants.name] = name;
    data[FirestoreConstants.introduce] = introduce;
    data[FirestoreConstants.introduce] = hasRoute;
    return data;
  }
}


class UserProgressModel {
  final bool isProfilePresent;
  final bool isRoutePresent;

  UserProgressModel({required this.isProfilePresent,required this.isRoutePresent});

  UserProgressModel.fromJson(Map<String, Object?> json)
      : this(
    isProfilePresent: ((json[FirestoreConstants.isProfilePresent]! as String).toLowerCase() == 'true'),
    isRoutePresent: ((json[FirestoreConstants.isRoutePresent]! as String).toLowerCase() == 'true'),
  );

}