class Traveler {
  final String id;
  final String _name;
  final String _mail;

  Traveler(this.id, this._name, this._mail);

  Traveler.fromJson(this.id, Map<String, dynamic> json)
      : _name = json['name'],
        _mail = json['mail'];

  Map<String, dynamic> toJson() => {'name': _name, 'mail': _mail};
}
