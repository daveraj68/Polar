import 'package:flutter/cupertino.dart';
import "package:polar/models/vote.dart";
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";
import "package:polar/state/vote.dart";
import "package:polar/state/authentication.dart";
import 'dart:math';

List<Vote> getVoteList() {
  // Mock Data
  List<Vote> voteList = List<Vote>();

  voteList.add(Vote(
    voteId: Uuid().v4(),
    voteTitle: 'Best Mobile Frameworks?',
    options: [
      {'Flutter': 70},
      {'React Native': 10},
      {'Xamarin': 1},
    ],
  ));

  voteList.add(Vote(
    voteId: Uuid().v4(),
    voteTitle: 'Best Web Frontend Frameworks?',
    options: [
      {'React': 80},
      {'Angular': 40},
      {'Vue': 20},
    ],
  ));

  voteList.add(Vote(
    voteId: Uuid().v4(),
    voteTitle: 'Best Web Backend Frameworks?',
    options: [
      {'Django': 50},
      {'Laravel': 30},
      {'Express.js': 50},
    ],
  ));

  return voteList;
}

// firestore collection name
const String kVotes = 'votes';
const String kTitle = 'title';

void createPoll(BuildContext context) async{
  final databaseReference = Firestore.instance;
  List<String> tecon=Provider.of<VoteState>(context, listen: false).tecon;
  print(tecon);
//  int code=new DateTime.now().millisecondsSinceEpoch;
//  code = code ~/ 10000000;
  var rng = new Random();
  var code = rng.nextInt(900000) + 100000;
  await databaseReference.collection("votes")
      .document(code.toString())
      .setData({
    'title': tecon[0],
    tecon[1]: 0,
    tecon[2]: 0,
    tecon[3]: 0,
  });
  Provider.of<VoteState>(context, listen: false).code=code.toString();
}

void getVoteListFromFirestore(BuildContext context) async {
//  Firestore.instance.collection(kVotes).snapshots().listen((data) {
//    List<Vote> voteList = List<Vote>();
//
//    data.documents.forEach((DocumentSnapshot document) {
//      Vote vote = Vote(voteId: document.documentID);
//
//      List<Map<String, int>> options = List();
//
//      document.data.forEach((key, value) {
//        if (key == kTitle) {
//          vote.voteTitle = value;
//        } else {
//          options.add({key: value});
//        }
//      });
//
//      vote.options = options;
//      voteList.add(vote);
//    });
//
//    Provider.of<VoteState>(context, listen: false).voteList = voteList;
//  });
  String code=Provider.of<VoteState>(context, listen: false).getCode();
  var document = await Firestore.instance.collection(kVotes).document(code).get().then((document) {
    if(document.exists){
      List<Vote> voteList = List<Vote>();

      voteList.add(mapFirestoreDocToVote(document));

      Provider.of<VoteState>(context, listen: false).voteList = voteList;
    }
    Provider.of<VoteState>(context, listen: false).setCode(null);

  });
}

Vote mapFirestoreDocToVote(document) {
  Vote vote = Vote(voteId: document.documentID);
  List<Map<String, int>> options = List();
  document.data.forEach((key, value) {
    if (key == kTitle) {
      vote.voteTitle = value;
    }
    else if(key=="voted"){

    }
    else {
      options.add({key: value});
    }
  });

  vote.options = options;
  return vote;
}

void markVote(String voteId, String option, BuildContext context) async {
  // increment value

  Firestore.instance.collection(kVotes).document(voteId).updateData({
    option: FieldValue.increment(1),
    "voted": FieldValue.arrayUnion([Provider.of<AuthenticationState>(context, listen: false).uid]),
  });
}

void retrieveMarkedVoteFromFirestore({String voteId, BuildContext context}) {
  // Retrieve updated doc from server
  Firestore.instance.collection(kVotes).document(voteId).get().then((document) {
    Provider.of<VoteState>(context, listen: false).activeVote =
        mapFirestoreDocToVote(document);
  });
}

