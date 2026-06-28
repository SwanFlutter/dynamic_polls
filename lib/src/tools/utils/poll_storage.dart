import 'package:get_x_storage/get_x_storage.dart';

class PollStorage {
  static final PollStorage _instance = PollStorage._internal();
  late GetXStorage _storage;

  factory PollStorage() {
    return _instance;
  }

  PollStorage._internal();

  static Future<void> init() async {
    await GetXStorage.init();
    _instance._storage = GetXStorage();
  }

  Future<void> saveVote(String pollId, int optionIndex) async {
    await _storage.write(key: 'vote_$pollId', value: optionIndex);
  }

  int? getVote(String pollId) {
    return _storage.read<int>(key: 'vote_$pollId');
  }

  bool hasVoted(String pollId) {
    return _storage.hasData(key: 'vote_$pollId');
  }

  Future<void> clearVote(String pollId) async {
    await _storage.remove(key: 'vote_$pollId');
  }

  Future<void> saveMultipleVotes(String pollId, List<int> optionIndices) async {
    await _storage.writeList<int>(
      key: 'multi_vote_$pollId',
      value: optionIndices,
    );
  }

  List<int>? getMultipleVotes(String pollId) {
    return _storage.readList<int>(key: 'multi_vote_$pollId');
  }

  bool hasMultipleVotes(String pollId) {
    return _storage.hasData(key: 'multi_vote_$pollId');
  }

  Future<void> clearMultipleVotes(String pollId) async {
    await _storage.remove(key: 'multi_vote_$pollId');
  }
}
