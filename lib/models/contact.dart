class Contact {
  final String username;
  final bool status;
  final int phone;
  final String documentId;

  Contact({this.username, this.status, this.phone, this.documentId});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'status': status,
      'phone': phone,
    };
  }

  static Contact fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Contact(
      username: map['username'],
      status: map['status'],
      phone: map['phone'],
      documentId: documentId,
    );
  }
}
