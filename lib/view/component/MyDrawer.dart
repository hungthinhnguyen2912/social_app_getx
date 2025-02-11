import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_social_app_getx/constants.dart';
import 'package:minimal_social_app_getx/view/page/Log_in_page.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Icon(Icons.home,size: 72,)),
          ListTile(
            title: Text('H O M E'),
            leading: Icon(Icons.home),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            title: Text('P R O F I L E'),
            leading: Icon(Icons.account_circle_outlined),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('C H A T'),
            leading: Icon(Icons.chat_bubble),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('Log Out'),
            leading: Icon(Icons.logout),
            onTap: () {
              Get.to(LogInPage());
            },
          )
        ],
      ),
    );
  }

}
