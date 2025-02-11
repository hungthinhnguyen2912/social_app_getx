class User {
  final String name;
  final String email;
  final String uid;

//<editor-fold desc="Data Methods">
  const User({
    required this.name,
    required this.email,
    required this.uid,
  });

  Map <String, dynamic> toJson() =>
      {
        "name": name,
        "email": email,
        "uid": uid
      };

}