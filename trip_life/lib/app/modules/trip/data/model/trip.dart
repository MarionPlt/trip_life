import 'dart:core';
import '../../../traveller/data/model/traveller.dart';

class Trip {
  int _id;
  String _title;
  String _dateBegin;
  String _dateEnd;
  String _lieu;
  String _notes;
  List<Traveller> _invitedUsers = [];

  Trip(this._id, this._title, this._dateBegin, this._dateEnd, this._lieu,
      this._notes);

  List<Traveller> get invitedUsers => _invitedUsers;

  String get notes => _notes;

  String get lieu => _lieu;

  String get dateEnd => _dateEnd;

  String get dateBegin => _dateBegin;

  String get title => _title;

  int get id => _id;

  void invite(Traveller _buddy){
    if(_buddy != null){
      _invitedUsers.add(_buddy);
    }
  }
}



