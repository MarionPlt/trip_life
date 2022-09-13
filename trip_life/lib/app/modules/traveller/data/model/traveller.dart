class Traveller {
  int _id;
  String _name;
  String _mail;

  Traveller(this._id, this._name, this._mail);

  Traveller.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _mail = json['mail'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'mail': _mail,
      };
}