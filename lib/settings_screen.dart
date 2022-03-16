import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定画面'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black38),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: 18,
                    dense: true,
                    onTap: () {},
                    title: const Text(
                      'アカウント設定',
                      style: TextStyle(locale: Locale('ja'), fontSize: 16),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black38),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: 18,
                    dense: true,
                    onTap: () {},
                    title: const Text(
                      '言語設定',
                      style: TextStyle(locale: Locale('ja'), fontSize: 16),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
