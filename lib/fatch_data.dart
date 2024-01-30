import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_parsing/User.dart';
import 'package:json_parsing/api_helper.dart';

class FatchData extends StatefulWidget {
  const FatchData({super.key});

  @override
  State<FatchData> createState() => _FatchDataState();
}

class _FatchDataState extends State<FatchData> {
  List<Users> userList = [];

  @override
  void initState() {
    ApiHelper().getApiData("users").then((value) {
      try {
        userList = usersFromJson(value);
        setState(() {});
      } catch (e, s) {
        print(e);
        print(s);
      }
    });


    ApiHelper().getApiData("posts").then((value) {
      print("posts data $value");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Data"),
      ),
      body: userList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                var user = userList[index];
                return ListTile(
                  leading: CircleAvatar(child: Text("${user.id ?? 0}")),
                  title: Text(user.name ?? ""),
                  subtitle: Text(user.email ?? ""),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // var future = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
          // userList = usersFromJson(future.body);
          // setState(() {
          // });

          ApiHelper helper = ApiHelper();
          ApiHelper helper1 = ApiHelper();
          ApiHelper helper2 = ApiHelper();
          ApiHelper helper3 = ApiHelper();
          ApiHelper helper4 = ApiHelper();

          print(helper.hashCode);
          print(helper1.hashCode);
          print(helper2.hashCode);
          print(helper3.hashCode);
          print(helper4.hashCode);
        },
      ),
    );
  }
}
