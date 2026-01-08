// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserDataModel {
  /// The username or identifier of the user who is voting, if any.
  final String? userToVote;

  /// The unique identifier of the user, if available.
  final String? userId;

  /// The country of the user, if provided.
  final String? country;

  /// The gender of the user, if specified.
  final String? gender;

  /// The age of the user, if available.
  final int? age;

  /// The phone number of the user, if provided.
  final int? phone;
  UserDataModel({
    this.userToVote,
    this.userId,
    this.country,
    this.gender,
    this.age,
    this.phone,
  });
}
