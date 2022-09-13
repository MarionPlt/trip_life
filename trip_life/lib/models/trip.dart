import 'dart:core';
import 'userTrip.dart';

class Trip {
  String _id;
  String _title;
  String _dateBegin;
  String _dateEnd;
  String _lieu;
  String _notes;
  List<UserTrip> _invitedUsers = [];

  Trip(this._id, this._title, this._dateBegin, this._dateEnd, this._lieu,
      this._notes);

  List<UserTrip> get invitedUsers => _invitedUsers;

  Trip.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _title = json['title'],
        _dateBegin = json['dateBegin'],
        _dateEnd = json['dateEnd'],
        _lieu = json['lieu'],
        _notes = json['notes'],
        _invitedUsers = json['invitedUsers'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'title': _title,
        'dateBegin': _dateBegin,
        'dateEnd': _dateEnd,
        'lieu': _lieu,
        'notes': _notes,
        'invitedUsers': _invitedUsers
      };
}
