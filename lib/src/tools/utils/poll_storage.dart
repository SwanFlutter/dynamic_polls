import 'package:shared_preferences/shared_preferences.dart';

class PollStorage {
  static final PollStorage _instance = PollStorage._internal();
  late SharedPreferences _prefs;

  factory PollStorage() {
    return _instance;
  }

  PollStorage._internal();

  static Future<void> init() async {
    _instance._prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveVote(String pollId, int optionIndex) async {
    await _prefs.setInt('vote_$pollId', optionIndex);
  }

  int? getVote(String pollId) {
    return _prefs.getInt('vote_$pollId');
  }

  bool hasVoted(String pollId) {
    return _prefs.containsKey('vote_$pollId');
  }

  Future<void> clearVote(String pollId) async {
    await _prefs.remove('vote_$pollId');
  }

  Future<void> saveMultipleVotes(String pollId, List<int> optionIndices) async {
    await _prefs.setStringList(
      'multi_vote_$pollId',
      optionIndices.map((e) => e.toString()).toList(),
    );
  }

  List<int>? getMultipleVotes(String pollId) {
    final data = _prefs.getStringList('multi_vote_$pollId');
    return data?.map((e) => int.parse(e)).toList();
  }

  bool hasMultipleVotes(String pollId) {
    return _prefs.containsKey('multi_vote_$pollId');
  }

  Future<void> clearMultipleVotes(String pollId) async {
    await _prefs.remove('multi_vote_$pollId');
  }
}
