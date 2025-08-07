import 'package:flutter/material.dart';
import 'package:frontend/screens/widgets/logout_button.dart';
import 'menu_item_widget.dart';
import 'user_account.dart';
import 'package:frontend/screens/auth/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SidebarMenu extends StatefulWidget{
  const SidebarMenu ({super.key, required this.userAccount});

  final UserAccount userAccount;

  @override
  State<StatefulWidget> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  int _selectedIndex = 0;
  late UserAccount _userAccount;
  final List<Map<String, dynamic>> _menuItems = [
    {
      'icon': Icons.home,'title': 'Trang chủ',
      'onTap': () {
        // Handle home tap
      },
    },
    {
      'icon': Icons.calendar_month,'title': 'Theo dõi vòng kinh',
      'onTap': () {
        // Handle settings tap
      },
    },
    {
      'icon': Icons.menu_book,'title': 'Tư vấn kiến thức',
      'onTap': () {
        // Handle logout tap
      },
    },
    {
      'icon': Icons.person_search,'title': 'Tư vấn chuyên gia',
      'onTap': () {
        // Handle logout tap
      },
    },
    {
      'icon': Icons.settings,'title': 'Quản lý tài khoản',
      'onTap': () {
        // Handle logout tap
      },
    },
  ];
  @override
  void initState() {
    super.initState();
    _userAccount = widget.userAccount;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 200,
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.pink, size: 30),
                      SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Floria',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Sức khỏe phụ nữ',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                //Menu items
                ...MenuItemWidget.buildMenuItems(
                  menuItems: _menuItems,
                  selectedIndex: _selectedIndex,
                  onItemTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),

              ],
            ),

            Column(
              children: [
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.pinkAccent,
                    child: Text(
                      (_userAccount != null && _userAccount.name.isNotEmpty)
                          ? _userAccount.name[0].toUpperCase()
                          : 'N',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text((_userAccount != null && _userAccount.name.isNotEmpty) ? _userAccount.name : "Người dùng"),
                  subtitle: Text((_userAccount != null && _userAccount.email.isNotEmpty) ? _userAccount.email : "Đang tải..."),
                ),

                const LogoutButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}