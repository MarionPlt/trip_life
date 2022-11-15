class Traveler {
  final String id;
  final String name;
  final String mail;

  Traveler(this.id, this.name, this.mail);

  Traveler.fromJson(this.id, Map<String, dynamic> json)
      : name = json['name'],
        mail = json['mail'];

  Map<String, dynamic> toJson() => {'name': name, 'mail': mail};
}
