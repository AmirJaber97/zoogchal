import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:zoog/models/contact.dart';

class FirestoreService {
  final CollectionReference _contactsCollectionReference =
  Firestore.instance.collection('users');

  Future getContacts(String username) async {
    List<Contact> contactsList;
    try {
      var contacts = await _contactsCollectionReference.getDocuments();
      print("Contacts ${contacts.documents.length}");
      if(contacts.documents.isNotEmpty){
        contactsList = contacts.documents
            .map((snapshot) => Contact.fromMap(snapshot.data, snapshot.documentID))
            .where((element) => element.username != username)
            .toList();
        print(contactsList.first.username);
        return contactsList;
      }
    } catch (e) {
      if(e is PlatformException) {
        return e.message;
      }
       return e.toString();
    }
  }
}