class PollDataUtils {
  // Static method to calculate the percentage of votes for each option
  static Map<int, double> calculatePercentages(
      {required int totalVotes, // Total number of votes cast
      required Map<int, int>
          votes, // Map containing the number of votes for each option
      required List<String> options // List of options available for the poll
      }) {
    Map<int, double> percentages =
        {}; // Initialize an empty map to store percentages

    // Iterate over the options using their index
    options.asMap().forEach((index, _) {
      // Calculate the percentage of votes for the current option
      double percentage = totalVotes > 0
          ? ((votes[index] ?? 0) / totalVotes) *
              100 // Calculate percentage if total votes are greater than zero
          : 0.0; // Set percentage to 0 if there are no votes

      // Store the calculated percentage in the map, formatted to one decimal place
      percentages[index] = double.parse(percentage.toStringAsFixed(1));
    });

    // Return the map containing the percentages for each option
    return percentages;
  }
}
