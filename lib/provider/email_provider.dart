import 'package:flutter/foundation.dart';
import 'package:flutter_app_2/email.dart';

class EmailProvider extends ChangeNotifier {
  List<Email> listEmail;
  List<Email> listEmailFilter;

  EmailProvider() {
    initEmail();
  }

  initEmail() {
    listEmail = List()
      ..add(Email(id: 1, title: "Hello 1", description: "looooo", time: "12:56"))..add(Email(id: 2,
          title: "Hello 2",
          description: "looooo",
          time: "12:56",
          favorite: true));


//      ..add(
//          Email(title: "Hello 3", description: "looooo", time: "12:56"))..add(Email(title: "Hello 4", description: "looooo", time: "12:56"))..add(
//          Email(title: "Hello 5", description: "looooo", time: "12:56"))..add(Email(title: "Hello 6", description: "looooo", time: "12:56"));
    listEmailFilter = List.of(listEmail);
  }

  filter(String text) {
    listEmailFilter = listEmail.where((email) {
      return email.title.contains(text);
    }).toList();
    notifyListeners();
  }

  int get countEmailFiltered {
    return listEmailFilter.length;
  }

  Email getEmailFiltered(int index) {
    return listEmailFilter[index];
  }

  toggleFavorite(int index) {
    listEmailFilter[index].favorite = !listEmailFilter[index].favorite;
    for (int i = 0; i < listEmail.length; i++) {
      if (listEmail[i].id == listEmailFilter[index].id) {
        listEmail[i].favorite = listEmailFilter[index].favorite;
        break;
      }
    }
    notifyListeners();
  }
}