import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoog/app/localization.dart';
import 'package:zoog/constants/app_strings.dart';
import 'package:zoog/enums/notifier_state.dart';
import 'package:zoog/models/contact.dart';
import 'package:zoog/ui/home/home_viewmodel.dart';
import 'package:zoog/ui/setup/app_base_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.translate(AppStrings.appName)),
      ),
      body: BaseWidget<HomeViewModel>(
        viewModel: HomeViewModel(),
        builder: (_, model, __) {
          return Center(
            child: GestureDetector(
                onTap: () async {
                  await model.fetchContacts("amir").then((value) {
                    navigator.push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return model.state == NotifierState.Loading ? CircularProgressIndicator() :
                        Scaffold(
                          body: ListView.builder(itemCount: model.contacts.length,itemBuilder: (context, index){
                            return ListTile(title: Text(model.contacts[index].username),);
                          }),
                        );
                      },
                    ));
                  });
                },
                child: Text('Click me')),
          );
        },
      ),
    );
  }
}
