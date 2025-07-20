# 🌸 Floria - Login & Signup Application

A modern authentication application built with Flutter frontend and Spring Boot backend, featuring secure user registration and login functionality.

## 📱 Features

- **User Registration**: Secure signup with password hashing
- **User Login**: Authenticated login with session management
- **Cross-Platform**: Works on Android, iOS, Web, and Desktop
- **Modern UI**: Beautiful and responsive Flutter interface
- **Secure Backend**: Spring Boot with MySQL database
- **Password Security**: BCrypt password hashing

## 🏗️ Architecture

```
Floria/
├── frontend/          # Flutter application
│   ├── lib/
│   │   ├── screens/
│   │   │   └── auth/
│   │   │       ├── login_screen.dart
│   │   │       ├── signup_screen.dart
│   │   │       └── widgets/
│   │   │           ├── login_form.dart
│   │   │           └── signup_form.dart
│   │   └── main.dart
│   └── pubspec.yaml
└── backend/           # Spring Boot application
    ├── src/main/java/com/example/backend/
    │   ├── login/
    │   │   ├── Login.java
    │   │   ├── LoginRequest.java
    │   │   └── CheckPassword.java
    │   ├── signup/
    │   │   ├── Signup.java
    │   │   ├── SignupRequest.java
    │   │   ├── SignupController.java
    │   │   └── HashPassword.java
    │   └── database/
    │       └── DBConnection.java
    └── pom.xml
```

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** (3.0 or higher)
- **Java JDK** (11 or higher)
- **Maven** (3.6 or higher)
- **MySQL** (8.0 or higher)
- **Android Studio** / **VS Code**

### Backend Setup

1. **Navigate to backend directory:**

   ```bash
   cd backend
   ```

2. **Configure database connection:**
   Edit `src/main/resources/application.properties`:

   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/floria_db
   spring.datasource.username=your_username
   spring.datasource.password=your_password
   ```

3. **Create MySQL database:**

   ```sql
   CREATE DATABASE floria_db;
   ```

4. **Run the Spring Boot application:**

   ```bash
   mvn spring-boot:run
   ```

   The backend will be available at `http://localhost:8080`

### Frontend Setup

1. **Navigate to frontend directory:**

   ```bash
   cd frontend
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the Flutter application:**
   ```bash
   flutter run
   ```

## 📋 API Endpoints

### Authentication Endpoints

- **POST** `/api/signup` - User registration

  ```json
  {
    "username": "user@example.com",
    "password": "securepassword"
  }
  ```

- **POST** `/api/login` - User authentication
  ```json
  {
    "username": "user@example.com",
    "password": "securepassword"
  }
  ```

## 🛠️ Technologies Used

### Frontend

- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **Material Design** - UI components

### Backend

- **Spring Boot** - Java framework
- **Spring Security** - Authentication & authorization
- **MySQL** - Database
- **BCrypt** - Password hashing
- **Maven** - Build tool

## 📱 Screenshots

### Login Screen

- Clean and modern login interface
- Email/username and password fields
- "Remember me" functionality
- Link to signup page

### Signup Screen

- User registration form
- Password confirmation
- Terms and conditions
- Link to login page

## 🔒 Security Features

- **Password Hashing**: BCrypt algorithm for secure password storage
- **Input Validation**: Server-side validation for all user inputs
- **SQL Injection Prevention**: Prepared statements and parameterized queries
- **Cross-Platform Security**: Secure communication between frontend and backend

## 🚀 Deployment

### Backend Deployment

1. Build the JAR file:
   ```bash
   mvn clean package
   ```
2. Deploy to your preferred cloud platform (AWS, Google Cloud, Azure)

### Frontend Deployment

1. Build for web:
   ```bash
   flutter build web
   ```
2. Deploy the `build/web` folder to your web server

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**NhanKhang15**

- GitHub: [@NhanKhang15](https://github.com/NhanKhang15)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Spring Boot community for the robust backend framework
- All contributors and supporters

---

⭐ **Star this repository if you found it helpful!**
