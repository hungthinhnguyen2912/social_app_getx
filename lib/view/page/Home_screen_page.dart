import 'package:flutter/material.dart';
import 'package:minimal_social_app_getx/view/component/MyDrawer.dart';

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('H O M E'),
        centerTitle: true,
      ),
      body: Center(child: Text('Home screen'),),
      drawer: MyDrawer(),
    );
  }
}
