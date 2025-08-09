import 'package:flutter/material.dart';
import '../widgets/sidebar_menu.dart';
import '../widgets/user_account.dart';
import '../menstrual_cycle_tracking/tracking.dart';

class HomePage extends StatefulWidget {
  final UserAccount? userAccount;
  const HomePage({Key? key, this.userAccount}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getBodyContent() {
    switch (_selectedIndex) {
      case 0:
        return Center(child: Text('Home page content here'));
      case 1:
        return Tracking(); // Display Tracking widget
      case 2:
        return Center(child: Text('Tư vấn kiến thức content here'));
      case 3:
        return Center(child: Text('Tư vấn chuyên gia content here'));
      case 4:
        return Center(child: Text('Quản lý tài khoản content here'));
      default:
        return Center(child: Text('Home page content here'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.userAccount != null
          ? SidebarMenu(
              userAccount: widget.userAccount!,
              selectedIndex: _selectedIndex, // Pass selectedIndex
              onItemSelected: _onItemSelected, // Pass callback
            )
          : null,
      appBar: AppBar(
        title: const Text('Trang chính'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: _getBodyContent(),
    );
  }
}