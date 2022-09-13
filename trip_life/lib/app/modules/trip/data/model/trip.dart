import 'dart:core';
import 'package:trip_life/app/modules/traveller/data/model/traveller.dart';

class Trip {
  String _id;
  String _title;
  String _dateBegin;
  String _dateEnd;
  String _lieu;
  String _notes;
  List<Traveller> _members = [];

  Trip(this._id, this._title, this._dateBegin, this._dateEnd, this._lieu,
      this._notes);

  List<Traveller> get invitedUsers => _members;

  Trip.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _title = json['title'],
        _dateBegin = json['dateBegin'],
        _dateEnd = json['dateEnd'],
        _lieu = json['lieu'],
        _notes = json['notes'],
        _members = json['members'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'title': _title,
        'dateBegin': _dateBegin,
        'dateEnd': _dateEnd,
        'lieu': _lieu,
        'notes': _notes,
        'members': _members
      };
}
