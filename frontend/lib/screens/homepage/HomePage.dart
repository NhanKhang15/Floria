import 'package:flutter/material.dart';
import '../widgets/sidebar_menu.dart';
import '../widgets/user_account.dart';

class HomePage extends StatelessWidget {
  final UserAccount? userAccount;
  const HomePage({Key? key, this.userAccount}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: userAccount != null ? SidebarMenu(userAccount: userAccount!) : null,

      appBar: AppBar(
        title: const Text('Trang chính'),
        leading: Builder(
          builder: (context) => // cần builder vì Scaffold chưa build xong
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(), // mở drawer
              ),
        ),
      ),

      body: const Center(
        child: Text('Home page content here'),
      ),
    );
  }
}