class Traveler {
  final String _name;
  final String _mail;

  Traveler(this._name, this._mail);

  Traveler.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _mail = json['mail'];

  Map<String, dynamic> toJson() => {'name': _name, 'mail': _mail};
}
