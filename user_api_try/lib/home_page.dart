import 'package:flutter/material.dart';
import 'package:user_api_try/model/user_model.dart';
import 'package:user_api_try/service/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserService _userService = UserService();

  List<Data> users = [];

  @override
  void initState() {
    super.initState();
    _userService.fetchUser().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Api Learning!",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index].firstName! + users[index].lastName!),
          subtitle: Text(users[index].email!),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(users[index].avatar!),
          ),
        );
      },
    );
  }
}
