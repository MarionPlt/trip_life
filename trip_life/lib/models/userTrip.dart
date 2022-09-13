class UserTrip {
  String _id;
  String _name;
  String _mail;

  UserTrip(this._id, this._name, this._mail);

  UserTrip.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _mail = json['mail'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'mail': _mail,
      };
}
