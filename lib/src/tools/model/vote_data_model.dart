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
  final int totalVotes;
  final Map<int, int> optionVotes;
  final Map<int, double> percentages;
  final int? selectedOption;
  final String? userToVote;

  /// Creates a new [VoteData] instance.
  ///
  /// The [totalVotes] parameter is required and represents the total number of votes.
  ///
  /// The [optionVotes] parameter is required and represents a map where the keys are the option numbers
  /// and the values are the number of votes for each option.
  ///
  /// The [percentages] parameter is required and represents a map where the keys are the option numbers
  /// and the values are the percentages of each option.
  ///
  /// The [selectedOption] parameter is optional and represents the number of the selected option (if any).
  VoteData({
    required this.totalVotes,
    required this.optionVotes,
    required this.percentages,
    this.selectedOption,
    this.userToVote,
  });

  /// Converts the [VoteData] instance to a JSON object for sending to the server.
  ///
  /// The returned JSON object has the following structure:
  /// ```
  /// {
  ///   'totalVotes': <totalVotes>,
  ///   'optionVotes': <optionVotes>,
  ///   'percentages': <percentages>,
  ///   'selectedOption': <selectedOption>
  /// }
  /// ```
  ///
  /// Where `<totalVotes>` is the value of the [totalVotes] property, `<optionVotes>` is the value of the
  /// [optionVotes] property, `<percentages>` is the value of the [percentages] property, and `<selectedOption>`
  /// is the value of the [selectedOption] property.
  Map<String, dynamic> toJson() {
    return {
      'totalVotes': totalVotes,
      'optionVotes': optionVotes,
      'percentages':
          percentages.map((key, value) => MapEntry(key.toString(), value)),
      'selectedOption': selectedOption,
    };
  }
}
