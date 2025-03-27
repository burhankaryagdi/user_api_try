import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_screen/model/login_model.dart';
import 'package:login_screen/view/home_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<Data?> login() async {
    String email = emailController.text;
    String password = passwordController.text;

    setState(() {
      isLoading = true;
    });

    var url = Uri.parse("https://reqres.in/api/login");
    var res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    setState(() {
      isLoading = false;
    });

    if (res.statusCode == 200) {
      var jsonBody = jsonDecode(res.body);
      String token = jsonBody["token"];

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(token: token)),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Geçersiz Şifre veya Mail!")));
    }
    print("Response Status Code: ${res.statusCode}");
    print("Response Body: ${res.body}");
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  // Body widget
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/login2.png"),
          SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Kullanıcı Adı",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Şifre",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 20),
          isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[400],
                ),
                onPressed: login,
                child: Text(
                  "Giriş Yap!",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
        ],
      ),
    );
  }

  // AppBar widget
  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Login Page', style: TextStyle(fontSize: 30)),
      centerTitle: true,
      leading: Icon(Icons.person),
      backgroundColor: Colors.blueGrey[600],
    );
  }
}
