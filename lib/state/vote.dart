import "package:flutter/material.dart";
import "package:polar/models/vote.dart";
import 'package:polar/services/services.dart';

class VoteState with ChangeNotifier {
  List<Vote> _voteList;
  Vote _activeVote;
  String _selectedOptionInActiveVote;
  String _code;
  List<String> _tecon;

  get code => _code;

  set code(newValue){
    _code=newValue;
    notifyListeners();
  }

  void loadVoteList(BuildContext context) async {
    // _voteList =  getVoteList();
    getVoteListFromFirestore(context);
  }

  void saveVoteList(BuildContext context) async {
    createPoll(context);
  }

  void clearState() {
    _voteList = null;
    _activeVote = null;
    _selectedOptionInActiveVote = null;
  }

  List<Vote> get voteList => _voteList;

  set voteList(newValue) {
    _voteList = newValue;
    notifyListeners();
  }

  Vote get activeVote => _activeVote;

  String get selectedOptionInActiveVote => _selectedOptionInActiveVote;

  set activeVote(newValue) {
    _activeVote = newValue;
    notifyListeners();
  }

  void set selectedOptionInActiveVote(String newValue) {
    _selectedOptionInActiveVote = newValue;
    notifyListeners();
  }

  void setCode(String ucode) {
    _code = ucode;
    notifyListeners();
  }

  String getCode() {
    return _code;
  }

  set tecon(newValue) {
    _tecon = newValue;
    notifyListeners();
  }

  get tecon => _tecon;
}
