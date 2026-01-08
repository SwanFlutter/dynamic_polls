import 'package:get_x_storage/get_x_storage.dart';

class PollStorage {
  static final PollStorage _instance = PollStorage._internal();
  final _box = GetXStorage('dynamic_polls_storage');

  factory PollStorage() {
    return _instance;
  }

  PollStorage._internal();

  /// Initializes the storage. Should be called in main.dart or before using polls.
  static Future<void> init() async {
    await GetXStorage.init('dynamic_polls_storage');
  }

  /// Saves the user's vote for a specific poll.
  /// [pollId] is the unique identifier for the poll.
  /// [optionIndex] is the index of the option the user voted for.
  Future<void> saveVote(String pollId, int optionIndex) async {
    await _box.write(key: 'vote_$pollId', value: optionIndex);
  }

  /// Retrieves the saved vote for a specific poll.
  /// Returns the option index if found, otherwise null.
  int? getVote(String pollId) {
    return _box.read<int>(key: 'vote_$pollId');
  }

  /// Checks if the user has voted in a specific poll.
  bool hasVoted(String pollId) {
    return _box.hasData(key: 'vote_$pollId');
  }

  /// Removes a vote (e.g., if reselection is allowed and user clears vote - though usually reselection just overwrites).
  Future<void> clearVote(String pollId) async {
    await _box.remove(key: 'vote_$pollId');
  }
}
