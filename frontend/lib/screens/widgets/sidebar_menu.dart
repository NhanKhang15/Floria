import 'package:flutter/material.dart';
import 'package:frontend/screens/widgets/logout_button.dart';
import 'user_account.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({
    super.key,
    required this.userAccount,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final UserAccount userAccount;
  final int selectedIndex;
  final Function(int) onItemSelected;

  @override
  State<StatefulWidget> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  late UserAccount _userAccount;
  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.home, 'title': 'Trang chủ', 'onTap': null},
    {'icon': Icons.calendar_month, 'title': 'Theo dõi vòng kinh', 'onTap': null},
    {'icon': Icons.menu_book, 'title': 'Tư vấn kiến thức', 'onTap': null},
    {'icon': Icons.person_search, 'title': 'Tư vấn chuyên gia', 'onTap': null},
    {'icon': Icons.settings, 'title': 'Quản lý tài khoản', 'onTap': null},
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
          children: [
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
                ..._menuItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return ListTile(
                    leading: Icon(
                      item['icon'],
                      color: widget.selectedIndex == index ? Colors.pink : Colors.grey,
                    ),
                    title: Text(
                      item['title'],
                      style: TextStyle(
                        color: widget.selectedIndex == index ? Colors.pink : Colors.black,
                      ),
                    ),
                    selected: widget.selectedIndex == index,
                    onTap: () {
                      widget.onItemSelected(index); // Call the callback
                    },
                  );
                }).toList(),
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
                  title: Text(
                    (_userAccount != null && _userAccount.name.isNotEmpty)
                        ? _userAccount.name
                        : "Người dùng",
                  ),
                  subtitle: Text(
                    (_userAccount != null && _userAccount.email.isNotEmpty)
                        ? _userAccount.email
                        : "Đang tải...",
                  ),
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