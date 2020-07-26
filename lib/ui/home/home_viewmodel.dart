import 'package:get/get.dart';
import 'package:zoog/app/locator.dart';
import 'package:zoog/app/logger.dart';
import 'package:zoog/enums/notifier_state.dart';
import 'package:zoog/models/contact.dart';
import 'package:zoog/services/firestore_service.dart';
import 'package:zoog/ui/setup/app_base_model.dart';

class HomeViewModel extends BaseModel {
  var logger = getLogger("HomeViewModel");
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<Contact> _contacts;

  List<Contact> get contacts => _contacts;

  Future fetchContacts(String username) async {
    setNotifier(NotifierState.Loading);
    var contactsResult = await _firestoreService.getContacts(username);
    setNotifier(NotifierState.Loaded);
    if (contactsResult is List<Contact>) {
      _contacts = contactsResult;
      notifyListeners();
    } else {
      await Get.defaultDialog(title: "Failed to get contacts");
    }
  }
}
