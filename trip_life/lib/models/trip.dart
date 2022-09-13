import 'dart:core';
import 'userTrip.dart';

class Trip {
  int _id;
  String _title;
  String _dateBegin;
  String _dateEnd;
  String _lieu;
  String _notes;
  List<UserTrip> _invitedUsers = [];

  Trip(this._id, this._title, this._dateBegin, this._dateEnd, this._lieu,
      this._notes);

  List<UserTrip> get invitedUsers => _invitedUsers;

  String get notes => _notes;

  String get lieu => _lieu;

  String get dateEnd => _dateEnd;

  String get dateBegin => _dateBegin;

  String get title => _title;

  int get id => _id;

  void invite(UserTrip _buddy){
    if(_buddy != null){
      _invitedUsers.add(_buddy);
    }
  }
}



