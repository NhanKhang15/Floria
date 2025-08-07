class UserAccount {
  final String name;
  final String email;

  UserAccount({required this.name, required this.email});

  factory UserAccount.fromJson(Map<String, dynamic> json){
    return UserAccount(
      name: json['username'] ?? '', 
      email: json['email'] ?? '', 
    );
  }
}