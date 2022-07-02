class Todo {
  final int? id;
  final String phoneNumber;
  final String username;

  Todo({this.id, this.phoneNumber = "Unknown", this.username = "Unknown"});

  Map<String, dynamic> toMap() {
    return ({'id': id, 'phoneNumber': phoneNumber, 'username': username});
  }
}
