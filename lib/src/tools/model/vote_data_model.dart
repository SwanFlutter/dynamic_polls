// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

/// Represents the data for a vote.
///
/// This class holds the total number of votes, the number of votes for each option,
/// the percentages of each option, and the selected option (if any).
///
/// The [totalVotes] property holds the total number of votes.
///
/// The [optionVotes] property holds a map where the keys are the option numbers and the values
/// are the number of votes for each option.
///
/// The [percentages] property holds a map where the keys are the option numbers and the values
/// are the percentages of each option.
///
/// The [selectedOption] property holds the number of the selected option (if any).
class VoteData {
  /// The total number of votes.
  final int totalVotes;

  /// A map where the keys are the option numbers and the values are the number of votes for each option.
  final Map<int, int> optionVotes;

  /// A map where the keys are the option numbers and the values are the percentages of each option.
  final Map<int, double> percentages;

  /// The number of the selected option, if any.
  final int? selectedOption;

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

  /// Creates a new [VoteData] instance.
  ///
  /// The [totalVotes], [optionVotes], and [percentages] parameters are required.
  /// The other parameters are optional and provide additional user details.
  VoteData({
    required this.totalVotes,
    required this.optionVotes,
    required this.percentages,
    this.selectedOption,
    this.userToVote,
    this.userId,
    this.country,
    this.gender,
    this.age,
    this.phone,
  });

  /// Converts the [VoteData] instance to a JSON object for sending to the server.
  ///
  /// The returned JSON object has the following structure:
  /// ```
  /// {
  ///   'totalVotes': <totalVotes>,
  ///   'optionVotes': <optionVotes>,
  ///   'percentages': <percentages>,
  ///   'selectedOption': <selectedOption>,
  ///   'userToVote': <userToVote>,
  ///   'userId': <userId>,
  ///   'country': <country>,
  ///   'gender': <gender>,
  ///   'age': <age>,
  ///   'phone': <phone>
  /// }
  /// ```
  Map<String, dynamic> toJson() {
    return {
      'totalVotes': totalVotes,
      'optionVotes': optionVotes,
      'percentages':
          percentages.map((key, value) => MapEntry(key.toString(), value)),
      'selectedOption': selectedOption,
      'userToVote': userToVote,
      'userId': userId,
      'country': country,
      'gender': gender,
      'age': age,
      'phone': phone,
    };
  }

  VoteData copyWith({
    int? totalVotes,
    Map<int, int>? optionVotes,
    Map<int, double>? percentages,
    int? selectedOption,
    String? userToVote,
    String? userId,
    String? country,
    String? gender,
    int? age,
    int? phone,
  }) {
    return VoteData(
      totalVotes: totalVotes ?? this.totalVotes,
      optionVotes: optionVotes ?? this.optionVotes,
      percentages: percentages ?? this.percentages,
      selectedOption: selectedOption ?? this.selectedOption,
      userToVote: userToVote ?? this.userToVote,
      userId: userId ?? this.userId,
      country: country ?? this.country,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalVotes': totalVotes,
      'optionVotes': optionVotes,
      'percentages': percentages,
      'selectedOption': selectedOption,
      'userToVote': userToVote,
      'userId': userId,
      'country': country,
      'gender': gender,
      'age': age,
      'phone': phone,
    };
  }

  factory VoteData.fromMap(Map<String, dynamic> map) {
    return VoteData(
      totalVotes: map['totalVotes'] as int,
      optionVotes: Map<int, int>.from((map['optionVotes'] as Map<int, int>)),
      percentages:
          Map<int, double>.from((map['percentages'] as Map<int, double>)),
      selectedOption:
          map['selectedOption'] != null ? map['selectedOption'] as int : null,
      userToVote:
          map['userToVote'] != null ? map['userToVote'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      phone: map['phone'] != null ? map['phone'] as int : null,
    );
  }

  /// Serializes the [VoteData] instance to JSON format.
  String toJsonString() => json.encode(toMap());

  factory VoteData.fromJson(String source) =>
      VoteData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VoteData(totalVotes: $totalVotes, optionVotes: $optionVotes, percentages: $percentages, selectedOption: $selectedOption, userToVote: $userToVote, userId: $userId, country: $country, gender: $gender, age: $age, phone: $phone)';
  }

  @override
  bool operator ==(covariant VoteData other) {
    if (identical(this, other)) return true;

    return other.totalVotes == totalVotes &&
        mapEquals(other.optionVotes, optionVotes) &&
        mapEquals(other.percentages, percentages) &&
        other.selectedOption == selectedOption &&
        other.userToVote == userToVote &&
        other.userId == userId &&
        other.country == country &&
        other.gender == gender &&
        other.age == age &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return totalVotes.hashCode ^
        optionVotes.hashCode ^
        percentages.hashCode ^
        selectedOption.hashCode ^
        userToVote.hashCode ^
        userId.hashCode ^
        country.hashCode ^
        gender.hashCode ^
        age.hashCode ^
        phone.hashCode;
  }
}
