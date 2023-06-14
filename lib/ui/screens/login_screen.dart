import 'package:cs_task1/ui/screens/home/home.dart';
import 'package:cs_task1/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  Map<String, dynamic>? userProfile;
  bool _obscurePassword = true;
  void login(String email, String password) async {
    try {
      final dio = Dio();
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        List<dynamic> users = response.data;
        bool credentialsMatch = false;

        for (var user in users) {
          String usernameFromApi = user['email'];
          String passwordFromApi =
              user['email']; // Assuming password is same as username in the API

          if (email == usernameFromApi && password == passwordFromApi) {
            credentialsMatch = true;
            userProfile = user; // Assign the user profile data
            print(userProfile);
            break;
          }
        }

        if (credentialsMatch) {
          print('Username and password match with API');
          // Handle successful login here
          // For example, navigate to the home screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(userProfile: userProfile),
            ),
          );
        } else {
          print('Username or password do not match with API');
          // Show error message or handle error condition here
        }
      } else {
        print('API request failed');
        // Show error message or handle error condition here
      }
    } catch (e) {
      print(e.toString());
      // Show error message or handle exception here
    }
  }

  void validateAndSubmit() {
    String email = username.text.trim();
    String pass = password.text.trim();

    if (email.isNotEmpty && pass.isNotEmpty) {
      if (isValidEmail(email)) {
        // Valid email and non-empty password
        login(email, pass);
      } else {
        showErrorMessage('Please enter a valid email address');
      }
    } else {
      showErrorMessage('Please enter email and password');
    }
  }

  bool isValidEmail(String email) {
    // Add your email validation logic here
    // For example, you can use a regular expression to validate the email format
    return email.contains('@');
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildInitialInput(size),
    );
  }

  Widget buildInitialInput(Size size) => Center(
  child: Container(
    width: size.width * 0.9,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/lorem_icon.jpeg',
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 32.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            controller: username,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            controller: password,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: InputBorder.none,
            ),
            obscureText: _obscurePassword,
          ),
        ),
        const SizedBox(height: 32.0),
        SizedBox(
          width: size.width,
          height: 55.0,
          child: ElevatedButton(
            onPressed: validateAndSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.i.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            child: const Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  ),
);


  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
}
