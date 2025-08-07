import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../signup/signup_screen.dart';
import '../../homepage/HomePage.dart';
import '../../widgets/user_account.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/constants/config.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  
  UserAccount? _userAccount; 

  String result = "";
  bool _obscurePassword = true;

  Future<void> login() async{
      final response =await http.post(
      Uri.parse('${AppConfig.baseUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': _userController.text,
        'password': _passController.text,
      }),
    );

    final data = jsonDecode(response.body);
    // setState(() {
    //   result = data['message'];
    // });

  if (data["success"] == true) {
      setState(() {
        _userAccount = UserAccount.fromJson(data); // ✅ cập nhật state
      });

    // 👉 Sau đó chuyển hướng sang MainPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(userAccount: _userAccount)),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data["message"] ?? "Sai tài khoản hoặc mật khẩu")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDEFF4),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(image: AssetImage('assets/images/logo.png'), height: 100,),

              Text(
                'FLORIA',
                style: TextStyle(
                  color: Color(0xFFFF33CC),
                  fontSize: 28,
                  fontFamily: 'hideMelody',
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'Ứng dụng chăm sóc sức khỏe phụ nữ'
              ),
              
              SizedBox(height: 16),
//|||||||||||||||||||||||||||||||||||||||||||||||||||
              Container(
                width: 370,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Đăng Nhập',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Chào mừng bạn quay trở lại!',
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email *',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _userController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Nhập địa chỉ Email',
                        filled: true,
                        fillColor: Color(0xFFF1F1F1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mật Khẩu',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Quên Mật Khẩu?',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            colors: [Color(0xFFFF3366), Color(0xFF9F33FF)]),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {login();},
                        child: Text(
                          'Đăng Nhập',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(result, style: const TextStyle(fontSize: 16)),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("Hoặc tiếp tục với"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: FaIcon(FontAwesomeIcons.google, size: 18),
                            label: Text('Google'),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: FaIcon(FontAwesomeIcons.facebookF, size: 18),
                            label: Text('Facebook'),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Chưa có tài khoản'),
                        TextButton(
                          onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  SignupScreen(),
                                ),
                              );
                            },
                          child: Text(
                            'Đăng ký ngay',
                            style: TextStyle(color: Colors.redAccent),
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(height: 32), 

                  Column(
                    children: [
                      Text(
                        '© 2025 Floria. Tất cả quyền được bảo lưu.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('Điều khoản',
                                style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Bảo mật',
                                style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Hỗ trợ',
                                style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 32),
                  
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
